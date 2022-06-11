#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#
#------------------------------------------------------------------------------
cmake_minimum_required(VERSION 3.23 FATAL_ERROR)
#------------------------------------------------------------------------------
if (NOT CMAKE_BUILD_TYPE)
  set(CMAKE_BUILD_TYPE Release)
endif()
#------------------------------------------------------------------------------
# Add conan path to the cmake build tree
list(APPEND CMAKE_PREFIX_PATH ${CMAKE_BINARY_DIR})
list(APPEND CMAKE_MODULE_PATH ${CMAKE_BINARY_DIR})
list(APPEND CMAKE_MODULE_PATH ${CMAKE_SOURCE_DIR}/cmake)
#------------------------------------------------------------------------------
project(templatepp VERSION 1.0.0)
#------------------------------------------------------------------------------
# User options
option(BUILD_SHARED_LIBS "Build shared libraries" OFF)
option(BUILD_TESTS "Build unit tests" OFF)
option(BUILD_ARCHIVE "Build package" OFF)
option(BUILD_DOC "Build API documentation" OFF)
#------------------------------------------------------------------------------
include(build_options)
include(build_paths)
include(install_paths)
#------------------------------------------------------------------------------
# Generate API documentation
if (BUILD_DOC)
  add_subdirectory(doc)
  return()
endif()
#------------------------------------------------------------------------------
# Source
add_subdirectory(src)

if(BUILD_TESTS)
  include(CTest)
  include(GoogleTest)
  add_subdirectory(test)
endif()
#------------------------------------------------------------------------------
# Install project commons
file(WRITE ${CMAKE_BINARY_DIR}/VERSION ${PROJECT_VERSION})
install(
  FILES "${CMAKE_BINARY_DIR}/VERSION"
  DESTINATION .)
install(
  FILES "${CMAKE_SOURCE_DIR}/README.md"
  DESTINATION .)
install(
  FILES "${CMAKE_SOURCE_DIR}/LICENSE"
  DESTINATION .)
#------------------------------------------------------------------------------
include(export_config)
#------------------------------------------------------------------------------
# Execute CPack
if (BUILD_ARCHIVE)
  include(archive)
endif()
#------------------------------------------------------------------------------
#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#
