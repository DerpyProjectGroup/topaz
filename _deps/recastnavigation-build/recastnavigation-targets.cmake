# Generated by CMake

if("${CMAKE_MAJOR_VERSION}.${CMAKE_MINOR_VERSION}" LESS 2.8)
   message(FATAL_ERROR "CMake >= 2.8.0 required")
endif()
if(CMAKE_VERSION VERSION_LESS "2.8.3")
   message(FATAL_ERROR "CMake >= 2.8.3 required")
endif()
cmake_policy(PUSH)
cmake_policy(VERSION 2.8.3...3.22)
#----------------------------------------------------------------
# Generated CMake target import file.
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Protect against multiple inclusion, which would fail when already imported targets are added once more.
set(_cmake_targets_defined "")
set(_cmake_targets_not_defined "")
set(_cmake_expected_targets "")
foreach(_cmake_expected_target IN ITEMS RecastNavigation::DebugUtils RecastNavigation::Detour RecastNavigation::DetourCrowd RecastNavigation::DetourTileCache RecastNavigation::Recast)
  list(APPEND _cmake_expected_targets "${_cmake_expected_target}")
  if(TARGET "${_cmake_expected_target}")
    list(APPEND _cmake_targets_defined "${_cmake_expected_target}")
  else()
    list(APPEND _cmake_targets_not_defined "${_cmake_expected_target}")
  endif()
endforeach()
unset(_cmake_expected_target)
if(_cmake_targets_defined STREQUAL _cmake_expected_targets)
  unset(_cmake_targets_defined)
  unset(_cmake_targets_not_defined)
  unset(_cmake_expected_targets)
  unset(CMAKE_IMPORT_FILE_VERSION)
  cmake_policy(POP)
  return()
endif()
if(NOT _cmake_targets_defined STREQUAL "")
  string(REPLACE ";" ", " _cmake_targets_defined_text "${_cmake_targets_defined}")
  string(REPLACE ";" ", " _cmake_targets_not_defined_text "${_cmake_targets_not_defined}")
  message(FATAL_ERROR "Some (but not all) targets in this export set were already defined.\nTargets Defined: ${_cmake_targets_defined_text}\nTargets not yet defined: ${_cmake_targets_not_defined_text}\n")
endif()
unset(_cmake_targets_defined)
unset(_cmake_targets_not_defined)
unset(_cmake_expected_targets)


# Create imported target RecastNavigation::DebugUtils
add_library(RecastNavigation::DebugUtils STATIC IMPORTED)

set_target_properties(RecastNavigation::DebugUtils PROPERTIES
  INTERFACE_INCLUDE_DIRECTORIES "C:/Users/Chris/Desktop/CactuarLSB/server/_deps/recastnavigation-src/DebugUtils/Include"
  INTERFACE_LINK_LIBRARIES "WS2_32;dbghelp;Shlwapi;C:/Users/Chris/Desktop/CactuarLSB/server/ext/zmq/lib64/libzmq_64.lib;C:/Users/Chris/Desktop/CactuarLSB/server/ext/luajit/lib64/libluajit_64.lib;C:/Users/Chris/Desktop/CactuarLSB/server/ext/openssl/lib64/libcrypto.lib;C:/Users/Chris/Desktop/CactuarLSB/server/ext/openssl/lib64/libssl.lib;RecastNavigation::Recast;RecastNavigation::Detour;RecastNavigation::DetourTileCache"
)

# Create imported target RecastNavigation::Detour
add_library(RecastNavigation::Detour STATIC IMPORTED)

set_target_properties(RecastNavigation::Detour PROPERTIES
  INTERFACE_INCLUDE_DIRECTORIES "C:/Users/Chris/Desktop/CactuarLSB/server/_deps/recastnavigation-src/Detour/Include"
  INTERFACE_LINK_LIBRARIES "WS2_32;dbghelp;Shlwapi;C:/Users/Chris/Desktop/CactuarLSB/server/ext/zmq/lib64/libzmq_64.lib;C:/Users/Chris/Desktop/CactuarLSB/server/ext/luajit/lib64/libluajit_64.lib;C:/Users/Chris/Desktop/CactuarLSB/server/ext/openssl/lib64/libcrypto.lib;C:/Users/Chris/Desktop/CactuarLSB/server/ext/openssl/lib64/libssl.lib"
)

# Create imported target RecastNavigation::DetourCrowd
add_library(RecastNavigation::DetourCrowd STATIC IMPORTED)

set_target_properties(RecastNavigation::DetourCrowd PROPERTIES
  INTERFACE_INCLUDE_DIRECTORIES "C:/Users/Chris/Desktop/CactuarLSB/server/_deps/recastnavigation-src/DetourCrowd/Include"
  INTERFACE_LINK_LIBRARIES "WS2_32;dbghelp;Shlwapi;C:/Users/Chris/Desktop/CactuarLSB/server/ext/zmq/lib64/libzmq_64.lib;C:/Users/Chris/Desktop/CactuarLSB/server/ext/luajit/lib64/libluajit_64.lib;C:/Users/Chris/Desktop/CactuarLSB/server/ext/openssl/lib64/libcrypto.lib;C:/Users/Chris/Desktop/CactuarLSB/server/ext/openssl/lib64/libssl.lib;RecastNavigation::Detour"
)

# Create imported target RecastNavigation::DetourTileCache
add_library(RecastNavigation::DetourTileCache STATIC IMPORTED)

set_target_properties(RecastNavigation::DetourTileCache PROPERTIES
  INTERFACE_INCLUDE_DIRECTORIES "C:/Users/Chris/Desktop/CactuarLSB/server/_deps/recastnavigation-src/DetourTileCache/Include"
  INTERFACE_LINK_LIBRARIES "WS2_32;dbghelp;Shlwapi;C:/Users/Chris/Desktop/CactuarLSB/server/ext/zmq/lib64/libzmq_64.lib;C:/Users/Chris/Desktop/CactuarLSB/server/ext/luajit/lib64/libluajit_64.lib;C:/Users/Chris/Desktop/CactuarLSB/server/ext/openssl/lib64/libcrypto.lib;C:/Users/Chris/Desktop/CactuarLSB/server/ext/openssl/lib64/libssl.lib;RecastNavigation::Detour"
)

# Create imported target RecastNavigation::Recast
add_library(RecastNavigation::Recast STATIC IMPORTED)

set_target_properties(RecastNavigation::Recast PROPERTIES
  INTERFACE_INCLUDE_DIRECTORIES "C:/Users/Chris/Desktop/CactuarLSB/server/_deps/recastnavigation-src/Recast/Include"
  INTERFACE_LINK_LIBRARIES "WS2_32;dbghelp;Shlwapi;C:/Users/Chris/Desktop/CactuarLSB/server/ext/zmq/lib64/libzmq_64.lib;C:/Users/Chris/Desktop/CactuarLSB/server/ext/luajit/lib64/libluajit_64.lib;C:/Users/Chris/Desktop/CactuarLSB/server/ext/openssl/lib64/libcrypto.lib;C:/Users/Chris/Desktop/CactuarLSB/server/ext/openssl/lib64/libssl.lib"
)

# Import target "RecastNavigation::DebugUtils" for configuration "Debug"
set_property(TARGET RecastNavigation::DebugUtils APPEND PROPERTY IMPORTED_CONFIGURATIONS DEBUG)
set_target_properties(RecastNavigation::DebugUtils PROPERTIES
  IMPORTED_LINK_INTERFACE_LANGUAGES_DEBUG "CXX"
  IMPORTED_LOCATION_DEBUG "C:/Users/Chris/Desktop/CactuarLSB/server/_deps/recastnavigation-build/DebugUtils/Debug/DebugUtils-d.lib"
  )

# Import target "RecastNavigation::Detour" for configuration "Debug"
set_property(TARGET RecastNavigation::Detour APPEND PROPERTY IMPORTED_CONFIGURATIONS DEBUG)
set_target_properties(RecastNavigation::Detour PROPERTIES
  IMPORTED_LINK_INTERFACE_LANGUAGES_DEBUG "CXX"
  IMPORTED_LOCATION_DEBUG "C:/Users/Chris/Desktop/CactuarLSB/server/_deps/recastnavigation-build/Detour/Debug/Detour-d.lib"
  )

# Import target "RecastNavigation::DetourCrowd" for configuration "Debug"
set_property(TARGET RecastNavigation::DetourCrowd APPEND PROPERTY IMPORTED_CONFIGURATIONS DEBUG)
set_target_properties(RecastNavigation::DetourCrowd PROPERTIES
  IMPORTED_LINK_INTERFACE_LANGUAGES_DEBUG "CXX"
  IMPORTED_LOCATION_DEBUG "C:/Users/Chris/Desktop/CactuarLSB/server/_deps/recastnavigation-build/DetourCrowd/Debug/DetourCrowd-d.lib"
  )

# Import target "RecastNavigation::DetourTileCache" for configuration "Debug"
set_property(TARGET RecastNavigation::DetourTileCache APPEND PROPERTY IMPORTED_CONFIGURATIONS DEBUG)
set_target_properties(RecastNavigation::DetourTileCache PROPERTIES
  IMPORTED_LINK_INTERFACE_LANGUAGES_DEBUG "CXX"
  IMPORTED_LOCATION_DEBUG "C:/Users/Chris/Desktop/CactuarLSB/server/_deps/recastnavigation-build/DetourTileCache/Debug/DetourTileCache-d.lib"
  )

# Import target "RecastNavigation::Recast" for configuration "Debug"
set_property(TARGET RecastNavigation::Recast APPEND PROPERTY IMPORTED_CONFIGURATIONS DEBUG)
set_target_properties(RecastNavigation::Recast PROPERTIES
  IMPORTED_LINK_INTERFACE_LANGUAGES_DEBUG "CXX"
  IMPORTED_LOCATION_DEBUG "C:/Users/Chris/Desktop/CactuarLSB/server/_deps/recastnavigation-build/Recast/Debug/Recast-d.lib"
  )

# Import target "RecastNavigation::DebugUtils" for configuration "Release"
set_property(TARGET RecastNavigation::DebugUtils APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(RecastNavigation::DebugUtils PROPERTIES
  IMPORTED_LINK_INTERFACE_LANGUAGES_RELEASE "CXX"
  IMPORTED_LOCATION_RELEASE "C:/Users/Chris/Desktop/CactuarLSB/server/_deps/recastnavigation-build/DebugUtils/Release/DebugUtils.lib"
  )

# Import target "RecastNavigation::Detour" for configuration "Release"
set_property(TARGET RecastNavigation::Detour APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(RecastNavigation::Detour PROPERTIES
  IMPORTED_LINK_INTERFACE_LANGUAGES_RELEASE "CXX"
  IMPORTED_LOCATION_RELEASE "C:/Users/Chris/Desktop/CactuarLSB/server/_deps/recastnavigation-build/Detour/Release/Detour.lib"
  )

# Import target "RecastNavigation::DetourCrowd" for configuration "Release"
set_property(TARGET RecastNavigation::DetourCrowd APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(RecastNavigation::DetourCrowd PROPERTIES
  IMPORTED_LINK_INTERFACE_LANGUAGES_RELEASE "CXX"
  IMPORTED_LOCATION_RELEASE "C:/Users/Chris/Desktop/CactuarLSB/server/_deps/recastnavigation-build/DetourCrowd/Release/DetourCrowd.lib"
  )

# Import target "RecastNavigation::DetourTileCache" for configuration "Release"
set_property(TARGET RecastNavigation::DetourTileCache APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(RecastNavigation::DetourTileCache PROPERTIES
  IMPORTED_LINK_INTERFACE_LANGUAGES_RELEASE "CXX"
  IMPORTED_LOCATION_RELEASE "C:/Users/Chris/Desktop/CactuarLSB/server/_deps/recastnavigation-build/DetourTileCache/Release/DetourTileCache.lib"
  )

# Import target "RecastNavigation::Recast" for configuration "Release"
set_property(TARGET RecastNavigation::Recast APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(RecastNavigation::Recast PROPERTIES
  IMPORTED_LINK_INTERFACE_LANGUAGES_RELEASE "CXX"
  IMPORTED_LOCATION_RELEASE "C:/Users/Chris/Desktop/CactuarLSB/server/_deps/recastnavigation-build/Recast/Release/Recast.lib"
  )

# Import target "RecastNavigation::DebugUtils" for configuration "MinSizeRel"
set_property(TARGET RecastNavigation::DebugUtils APPEND PROPERTY IMPORTED_CONFIGURATIONS MINSIZEREL)
set_target_properties(RecastNavigation::DebugUtils PROPERTIES
  IMPORTED_LINK_INTERFACE_LANGUAGES_MINSIZEREL "CXX"
  IMPORTED_LOCATION_MINSIZEREL "C:/Users/Chris/Desktop/CactuarLSB/server/_deps/recastnavigation-build/DebugUtils/MinSizeRel/DebugUtils.lib"
  )

# Import target "RecastNavigation::Detour" for configuration "MinSizeRel"
set_property(TARGET RecastNavigation::Detour APPEND PROPERTY IMPORTED_CONFIGURATIONS MINSIZEREL)
set_target_properties(RecastNavigation::Detour PROPERTIES
  IMPORTED_LINK_INTERFACE_LANGUAGES_MINSIZEREL "CXX"
  IMPORTED_LOCATION_MINSIZEREL "C:/Users/Chris/Desktop/CactuarLSB/server/_deps/recastnavigation-build/Detour/MinSizeRel/Detour.lib"
  )

# Import target "RecastNavigation::DetourCrowd" for configuration "MinSizeRel"
set_property(TARGET RecastNavigation::DetourCrowd APPEND PROPERTY IMPORTED_CONFIGURATIONS MINSIZEREL)
set_target_properties(RecastNavigation::DetourCrowd PROPERTIES
  IMPORTED_LINK_INTERFACE_LANGUAGES_MINSIZEREL "CXX"
  IMPORTED_LOCATION_MINSIZEREL "C:/Users/Chris/Desktop/CactuarLSB/server/_deps/recastnavigation-build/DetourCrowd/MinSizeRel/DetourCrowd.lib"
  )

# Import target "RecastNavigation::DetourTileCache" for configuration "MinSizeRel"
set_property(TARGET RecastNavigation::DetourTileCache APPEND PROPERTY IMPORTED_CONFIGURATIONS MINSIZEREL)
set_target_properties(RecastNavigation::DetourTileCache PROPERTIES
  IMPORTED_LINK_INTERFACE_LANGUAGES_MINSIZEREL "CXX"
  IMPORTED_LOCATION_MINSIZEREL "C:/Users/Chris/Desktop/CactuarLSB/server/_deps/recastnavigation-build/DetourTileCache/MinSizeRel/DetourTileCache.lib"
  )

# Import target "RecastNavigation::Recast" for configuration "MinSizeRel"
set_property(TARGET RecastNavigation::Recast APPEND PROPERTY IMPORTED_CONFIGURATIONS MINSIZEREL)
set_target_properties(RecastNavigation::Recast PROPERTIES
  IMPORTED_LINK_INTERFACE_LANGUAGES_MINSIZEREL "CXX"
  IMPORTED_LOCATION_MINSIZEREL "C:/Users/Chris/Desktop/CactuarLSB/server/_deps/recastnavigation-build/Recast/MinSizeRel/Recast.lib"
  )

# Import target "RecastNavigation::DebugUtils" for configuration "RelWithDebInfo"
set_property(TARGET RecastNavigation::DebugUtils APPEND PROPERTY IMPORTED_CONFIGURATIONS RELWITHDEBINFO)
set_target_properties(RecastNavigation::DebugUtils PROPERTIES
  IMPORTED_LINK_INTERFACE_LANGUAGES_RELWITHDEBINFO "CXX"
  IMPORTED_LOCATION_RELWITHDEBINFO "C:/Users/Chris/Desktop/CactuarLSB/server/_deps/recastnavigation-build/DebugUtils/RelWithDebInfo/DebugUtils.lib"
  )

# Import target "RecastNavigation::Detour" for configuration "RelWithDebInfo"
set_property(TARGET RecastNavigation::Detour APPEND PROPERTY IMPORTED_CONFIGURATIONS RELWITHDEBINFO)
set_target_properties(RecastNavigation::Detour PROPERTIES
  IMPORTED_LINK_INTERFACE_LANGUAGES_RELWITHDEBINFO "CXX"
  IMPORTED_LOCATION_RELWITHDEBINFO "C:/Users/Chris/Desktop/CactuarLSB/server/_deps/recastnavigation-build/Detour/RelWithDebInfo/Detour.lib"
  )

# Import target "RecastNavigation::DetourCrowd" for configuration "RelWithDebInfo"
set_property(TARGET RecastNavigation::DetourCrowd APPEND PROPERTY IMPORTED_CONFIGURATIONS RELWITHDEBINFO)
set_target_properties(RecastNavigation::DetourCrowd PROPERTIES
  IMPORTED_LINK_INTERFACE_LANGUAGES_RELWITHDEBINFO "CXX"
  IMPORTED_LOCATION_RELWITHDEBINFO "C:/Users/Chris/Desktop/CactuarLSB/server/_deps/recastnavigation-build/DetourCrowd/RelWithDebInfo/DetourCrowd.lib"
  )

# Import target "RecastNavigation::DetourTileCache" for configuration "RelWithDebInfo"
set_property(TARGET RecastNavigation::DetourTileCache APPEND PROPERTY IMPORTED_CONFIGURATIONS RELWITHDEBINFO)
set_target_properties(RecastNavigation::DetourTileCache PROPERTIES
  IMPORTED_LINK_INTERFACE_LANGUAGES_RELWITHDEBINFO "CXX"
  IMPORTED_LOCATION_RELWITHDEBINFO "C:/Users/Chris/Desktop/CactuarLSB/server/_deps/recastnavigation-build/DetourTileCache/RelWithDebInfo/DetourTileCache.lib"
  )

# Import target "RecastNavigation::Recast" for configuration "RelWithDebInfo"
set_property(TARGET RecastNavigation::Recast APPEND PROPERTY IMPORTED_CONFIGURATIONS RELWITHDEBINFO)
set_target_properties(RecastNavigation::Recast PROPERTIES
  IMPORTED_LINK_INTERFACE_LANGUAGES_RELWITHDEBINFO "CXX"
  IMPORTED_LOCATION_RELWITHDEBINFO "C:/Users/Chris/Desktop/CactuarLSB/server/_deps/recastnavigation-build/Recast/RelWithDebInfo/Recast.lib"
  )

# This file does not depend on other imported targets which have
# been exported from the same project but in a separate export set.

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
cmake_policy(POP)