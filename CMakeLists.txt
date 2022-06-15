#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#

cmake_minimum_required(VERSION 3.23 FATAL_ERROR)

if (NOT CMAKE_BUILD_TYPE)
  set(CMAKE_BUILD_TYPE Release)
endif()

# Add conan path to the cmake build tree
list(APPEND CMAKE_PREFIX_PATH ${CMAKE_BINARY_DIR})
list(APPEND CMAKE_MODULE_PATH ${CMAKE_BINARY_DIR})
list(APPEND CMAKE_MODULE_PATH ${CMAKE_SOURCE_DIR}/cmake)

project(templatepp VERSION 1.0.0)

file(WRITE ${CMAKE_BINARY_DIR}/NAME ${PROJECT_NAME})
file(WRITE ${CMAKE_BINARY_DIR}/VERSION ${PROJECT_VERSION})

include(build_options)
include(build_paths)
include(install_paths)

# Generate API documentation
option(BUILD_DOC "Build API documentation (clang/gcc only)" OFF)
if (BUILD_DOC)
  add_subdirectory(doc)
  return()
endif()

option(COVERAGE "Generate code coverage (clang/gcc only)" OFF)
include(coverage)

option(SANITIZE "Enable code sanitizer (clang/gcc only)" OFF)
include(sanity_checks)

option(CLANG_DEVTOOLS "Enable clang dev tools (clang/gcc only)" OFF)
include(clang_devtools)

option(BUILD_TESTS "Build unit tests" OFF)

# Source
add_subdirectory(src)

if(BUILD_TESTS)
  include(CTest)
  include(GoogleTest)
  add_subdirectory(test)
endif()

# Install project commons
install(
  FILES "${CMAKE_BINARY_DIR}/VERSION"
  DESTINATION .)
install(
  FILES "${CMAKE_SOURCE_DIR}/README.md"
  DESTINATION .)
install(
  FILES "${CMAKE_SOURCE_DIR}/LICENSE"
  DESTINATION .)

include(export_config)
include(pack)

#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#
