/*
===========================================================================

Copyright © 2015 Darkstar Dev Teams

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

#ifndef _MARSHAL_STRING_H
#define _MARSHAL_STRING_H

#if defined(_MSC_VER)
#pragma warning(push)
#pragma warning(disable : 4351 4996)
#endif

#include <algorithm>
#include <sstream>
#include <string>

namespace marshal
{
    template <std::size_t capacity, bool precise = false>
    class string
    {
    private:
        char buffer[capacity] = {};

        template <bool condition = precise>
        typename std::enable_if<condition>::type cleanup(std::size_t index)
        {
            std::fill_n(buffer + index, capacity - index, '\0');
        }
        template <bool condition = precise>
        typename std::enable_if<!condition>::type cleanup(std::size_t index)
        {
            buffer[std::min(index, capacity - 1)] = '\0';
        }

        void assign(const std::string& text)
        {
            auto index = std::min(text.length(), capacity);
            std::copy_n(text.begin(), index, buffer);

            cleanup(index);
        }

    public:
        // Constructors
        string()
        {
        }

        // Copy
        template <std::size_t R, bool C>
        string(const string<R, C>& other)
        : string(std::string(other))
        {
        }
        string(const char* text)
        : string(std::string(text))
        {
        }

        string(const std::string& text)
        {
            assign(text);
        }

        // Conversions
        operator std::string() const
        {
            return std::string(buffer, buffer + capacity);
        }

        // Indexing
        char& operator[](std::size_t index)
        {
            return buffer[index];
        }

        // Dereference
        char& operator*()
        {
            return *buffer;
        }

        // Bool conversion, true if non-empty
        explicit operator bool() const
        {
            return buffer[0] != '\0';
        }

        // Container functions
        char* begin()
        {
            return buffer;
        }

        char* end()
        {
            return buffer + capacity;
        }

        const char* cbegin()
        {
            return buffer;
        }

        const char* cend()
        {
            return buffer + capacity;
        }

        const char* data()
        {
            return buffer;
        }

        std::size_t size()
        {
            return capacity;
        }
        std::size_t max_size()
        {
            return capacity;
        }

        // Stream operators
        template <std::size_t N, bool C>
        friend std::ostream operator<<(std::ostream& stream, const string& str);
        template <std::size_t N, bool C>
        friend std::istream operator>>(std::istream& stream, string& str);
    };

    template <std::size_t N, bool C>
    std::ostream& operator<<(std::ostream& stream, const string<N, C>& str)
    {
        return stream << std::string(str);
    }

    template <std::size_t N, bool C>
    std::istream& operator>>(std::istream& stream, string<N, C>& str)
    {
        std::string value;
        stream >> value;
        str.assign(value);
        return stream;
    }
} // namespace marshal

#if defined(_MSC_VER)
#pragma warning(pop)
#endif
#endif
