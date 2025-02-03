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
#pragma once

#include "cbasetypes.h"

#include <chrono>
#include <condition_variable>
#include <functional>
#include <mutex>

#include <nonstd/jthread.hpp>

class Watchdog
{
public:
    Watchdog(duration timeout, std::function<void()> callback);
    ~Watchdog();

    void update();

private:
    // Functions for the worker thread
    auto _calculateDeadline() const -> server_clock::time_point;
    auto _checkTimeout(const server_clock::time_point& deadline) const -> bool;
    auto _waitForTimeout(const server_clock::time_point& deadline) -> bool;
    void _handleTimeout();
    void _innerFunc();

    using voidFunc_t = std::function<void()>;

    duration m_timeout;

    std::atomic<bool>       m_running;
    std::atomic<time_point> m_lastUpdate;
    std::mutex              m_bottleneck;
    std::condition_variable m_stopCondition;

    std::function<void()> m_callback;

    nonstd::jthread m_workerThread;
};
