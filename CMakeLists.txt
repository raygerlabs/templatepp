#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#
#-------------------------------------------------------------------------------------------------------------------#
cmake_minimum_required(VERSION 3.23 FATAL_ERROR)
project(templatepp VERSION 0.2.0)

# Set default build type
if (NOT CMAKE_BUILD_TYPE)
  set(CMAKE_BUILD_TYPE Release)
endif()

# Project options
option(BUILD_SHARED_LIBS "Build shared libraries" ON)
option(BUILD_TESTING "Build unit tests" ON)

# Add the conan install path to the cmake build tree
list(APPEND CMAKE_PREFIX_PATH ${CMAKE_BINARY_DIR}) 
list(APPEND CMAKE_MODULE_PATH ${CMAKE_BINARY_DIR})

# Add the cmake config paths to the cmake build tree
list(APPEND CMAKE_MODULE_PATH ${CMAKE_CURRENT_LIST_DIR}/cmake)

# Build paths
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin)
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib)
set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib)
set(CMAKE_DEBUG_POSTFIX "d")

# Install paths
if(WIN32 AND NOT CYGWIN)
  set(CONFIG_INSTALL_DIR "${CMAKE_INSTALL_PREFIX}/cmake")
else()
  set(CONFIG_INSTALL_DIR "${CMAKE_INSTALL_PREFIX}/lib/cmake/${PROJECT_NAME}")
endif()
set(CONFIG_INSTALL_DIR "${CONFIG_INSTALL_DIR}" CACHE PATH "Installation path for CMake config files")
set(BIN_INSTALL_DIR "${CMAKE_INSTALL_PREFIX}/bin" CACHE PATH "Installation path for targeted binaries")
set(LIB_INSTALL_DIR "${CMAKE_INSTALL_PREFIX}/lib" CACHE PATH "Installation path for targeted libraries")
set(INCLUDE_INSTALL_DIR "${CMAKE_INSTALL_PREFIX}/include" CACHE PATH "Installation path for targeted public headers")

# Enforce C++ standard
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

# Enable position independent code
set(CMAKE_POSITION_INDEPENDENT_CODE ON)

# Export DLL
if (MSVC)
  set(CMAKE_WINDOWS_EXPORT_ALL_SYMBOLS ON)
endif()

# Specify default visibility of ELF symbols
set(CMAKE_CXX_VISIBILITY_PRESET hidden)
set(CMAKE_VISIBILITY_INLINES_HIDDEN ON)

# Enable IDE folders (eg. Visual Studio, Xcode...)
set_property(GLOBAL PROPERTY USE_FOLDERS ON)

# Enable verbose output for Makefile projects
set(CMAKE_VERBOSE_MAKEFILE ON)

# Use relative paths
# This is mostly to reduce path size for command-line limits on windows
if(WIN32)
  # This seems to break Xcode projects so definitely don't enable on Apple builds
  set(CMAKE_USE_RELATIVE_PATHS true)
  set(CMAKE_SUPPRESS_REGENERATION true)
endif()

# Add test support unless explicitly specified
if (BUILD_TESTING)
  include(CTest)
  include(GoogleTest)
endif()

add_subdirectory(templatepp)

include(package)
#-------------------------------------------------------------------------------------------------------------------#
#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#
