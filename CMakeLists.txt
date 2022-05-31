#---------------------------------------------------------------------#
cmake_minimum_required(VERSION 3.20)
project(templatepp VERSION 0.2.0)
#---------------------------------------------------------------------#
# User options
if (NOT CMAKE_BUILD_TYPE)
  set(CMAKE_BUILD_TYPE Release)
endif()
option(BUILD_SHARED_LIBS "Build shared libraries" ON)
option(BUILD_TESTING "Build unit tests" ON)
#---------------------------------------------------------------------#
# Add conan path to the cmake build tree
list(APPEND CMAKE_PREFIX_PATH ${CMAKE_BINARY_DIR})
list(APPEND CMAKE_MODULE_PATH ${CMAKE_BINARY_DIR})
# Add cmake util path to the cmake build tree
list(APPEND CMAKE_MODULE_PATH ${CMAKE_SOURCE_DIR}/cmake)
#---------------------------------------------------------------------#
# Build paths
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin)
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib)
set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib)
#---------------------------------------------------------------------#
# Common build options
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)
set(CMAKE_POSITION_INDEPENDENT_CODE ON)
set(CMAKE_CXX_VISIBILITY_PRESET hidden)
set(CMAKE_VISIBILITY_INLINES_HIDDEN ON)
set_property(GLOBAL PROPERTY USE_FOLDERS ON)
set(CMAKE_SUPPRESS_REGENERATION ON)
set(CMAKE_SUPPRESS_REGENERATION ON)
set(CMAKE_VERBOSE_MAKEFILE ON)
#---------------------------------------------------------------------#
# Source
add_subdirectory(src)
if (BUILD_TESTING)
  include(CTest)
  include(GoogleTest)
  add_subdirectory(tests)
endif()
#---------------------------------------------------------------------#
# Install project commons
file(WRITE ${CMAKE_BINARY_DIR}/VERSION ${PROJECT_VERSION})
install(FILES "${CMAKE_BINARY_DIR}/VERSION" DESTINATION .)
install(FILES "${CMAKE_SOURCE_DIR}/README.md" DESTINATION .)
install(FILES "${CMAKE_SOURCE_DIR}/LICENSE" DESTINATION .)
#---------------------------------------------------------------------#
# Package project
include(package)
#---------------------------------------------------------------------#
