#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#

cmake_minimum_required(VERSION 3.23 FATAL_ERROR)
project(templatepp VERSION 1.0.0)

#------------------------------------------------------------------------------
# General build config
#------------------------------------------------------------------------------

if (NOT CMAKE_BUILD_TYPE)
  set(CMAKE_BUILD_TYPE Release)
endif()

# Add conan path to the cmake build tree
list(APPEND CMAKE_PREFIX_PATH ${PROJECT_SOURCE_DIR})
list(APPEND CMAKE_MODULE_PATH ${PROJECT_SOURCE_DIR})
list(APPEND CMAKE_MODULE_PATH ${PROJECT_SOURCE_DIR}/cmake)

option(BUILD_SHARED_LIBS "Build shared libraries" OFF)
option(BUILD_TESTS       "Build unit tests" OFF)
option(ENABLE_LINT       "Enable static code analysis (clang/gcc only)" OFF)
option(ENABLE_SANITIZER  "Enable code sanitizer (clang/gcc only)" OFF)
option(ENABLE_COVERAGE   "Enable code coverage (clang/gcc only)" OFF)
option(GENERATE_DOC      "Generate API documentation (clang/gcc only)" OFF)
option(ONLY_DOC          "Generate API documentation only (clang/gcc only)" OFF)

include(build_options)
include(build_paths)
include(install_paths)
include(code_coverage)
include(static_analysis)
include(sanity_checks)
include(generate_export_headers)
include(generate_doc)
if (GENERATE_DOC AND ONLY_DOC)
  return()
endif()

#------------------------------------------------------------------------------
# Add source
#------------------------------------------------------------------------------

# Source files
add_subdirectory(src)

# Unit tests
if(BUILD_TESTS)
  include(CTest) # enable_testing()
  include(GoogleTest) # gtest_discover_tests(...)
  add_subdirectory(test)
endif()

#------------------------------------------------------------------------------
# Post build
#------------------------------------------------------------------------------

include(export_config)
include(pack)

#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#
