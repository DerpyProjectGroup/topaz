/*
===========================================================================

  Copyright (c) 2022 LandSandBoat Dev Teams

  This program is free software: you can redistribute it and/or modify
  it under the terms of the GNU General Public License as published by
  the Free Software Foundation, either version 3 of the License, or
  (at your option) any later version.

  This program is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  GNU General Public License for more details.

  You should have received a copy of the GNU General Public License
  along with this program.  If not, see http://www.gnu.org/licenses/

===========================================================================
*/

#include "watchdog.h"

Watchdog::Watchdog(duration timeout, std::function<void()> callback)
: m_timeout(timeout)
, m_callback(std::move(callback))
, m_lastUpdate(server_clock::now())
, m_running(true)
{
    m_workerThread = nonstd::jthread(&Watchdog::_innerFunc, this);
}

Watchdog::~Watchdog()
{
    if (m_running)
    {
        std::unique_lock<std::mutex> lock(m_bottleneck);

        m_running = false;
        m_stopCondition.notify_all();
    }
}

void Watchdog::update()
{
    std::unique_lock<std::mutex> lock(m_bottleneck);

    m_lastUpdate = server_clock::now();
}

server_clock::time_point Watchdog::_calculateDeadline() const
{
    TracyZoneScoped;

    return m_lastUpdate.load() + m_timeout;
}

bool Watchdog::_checkTimeout(const server_clock::time_point& deadline) const
{
    TracyZoneScoped;

    return !m_running || (server_clock::now() - m_lastUpdate.load()) >= m_timeout;
}

bool Watchdog::_waitForTimeout(const server_clock::time_point& deadline)
{
    TracyZoneScoped;

    std::unique_lock<std::mutex> lock(m_bottleneck);

    // clang-format off
    return m_stopCondition.wait_until(lock, deadline,
    [this, &deadline]
    {
        return _checkTimeout(deadline);
    });
    // clang-format on
}

void Watchdog::_handleTimeout()
{
    TracyZoneScoped;

    m_running = false;
    m_callback();
}

void Watchdog::_innerFunc()
{
    TracySetThreadName("Tick Watchdog");

    while (m_running)
    {
        const auto deadline = _calculateDeadline();

        if (_waitForTimeout(deadline))
        {
            if (!m_running)
            {
                break;
            }
        }

        if (m_running && _checkTimeout(deadline))
        {
            _handleTimeout();
            break;
        }
    }
}
