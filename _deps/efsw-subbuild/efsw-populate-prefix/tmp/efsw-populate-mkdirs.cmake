# Distributed under the OSI-approved BSD 3-Clause License.  See accompanying
# file Copyright.txt or https://cmake.org/licensing for details.

cmake_minimum_required(VERSION 3.5)

file(MAKE_DIRECTORY
  "C:/Users/Chris/Desktop/CactuarLSB/server/_deps/efsw-src"
  "C:/Users/Chris/Desktop/CactuarLSB/server/_deps/efsw-build"
  "C:/Users/Chris/Desktop/CactuarLSB/server/_deps/efsw-subbuild/efsw-populate-prefix"
  "C:/Users/Chris/Desktop/CactuarLSB/server/_deps/efsw-subbuild/efsw-populate-prefix/tmp"
  "C:/Users/Chris/Desktop/CactuarLSB/server/_deps/efsw-subbuild/efsw-populate-prefix/src/efsw-populate-stamp"
  "C:/Users/Chris/Desktop/CactuarLSB/server/_deps/efsw-subbuild/efsw-populate-prefix/src"
  "C:/Users/Chris/Desktop/CactuarLSB/server/_deps/efsw-subbuild/efsw-populate-prefix/src/efsw-populate-stamp"
)

set(configSubDirs Debug)
foreach(subDir IN LISTS configSubDirs)
    file(MAKE_DIRECTORY "C:/Users/Chris/Desktop/CactuarLSB/server/_deps/efsw-subbuild/efsw-populate-prefix/src/efsw-populate-stamp/${subDir}")
endforeach()
if(cfgdir)
  file(MAKE_DIRECTORY "C:/Users/Chris/Desktop/CactuarLSB/server/_deps/efsw-subbuild/efsw-populate-prefix/src/efsw-populate-stamp${cfgdir}") # cfgdir has leading slash
endif()