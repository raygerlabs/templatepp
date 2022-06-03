#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#
#----------------------------------------------------------------------
cmake_minimum_required(VERSION 3.23 FATAL_ERROR)
#----------------------------------------------------------------------
if (NOT CMAKE_BUILD_TYPE)
  set(CMAKE_BUILD_TYPE Release)
endif()
#----------------------------------------------------------------------
# Add conan path to the cmake build tree
list(APPEND CMAKE_PREFIX_PATH ${CMAKE_BINARY_DIR})
list(APPEND CMAKE_MODULE_PATH ${CMAKE_BINARY_DIR})
list(APPEND CMAKE_MODULE_PATH ${CMAKE_SOURCE_DIR}/cmake)
#----------------------------------------------------------------------
project(templatepp VERSION 0.4.0)
#----------------------------------------------------------------------
# User options
option(BUILD_SHARED_LIBS "Build shared libraries" ON)
option(BUILD_TESTING "Build unit tests" ON)
option(BUILD_PACKAGING "Build packages" ON)
#----------------------------------------------------------------------
include(build_options)
include(build_paths)
include(install_paths)
#----------------------------------------------------------------------
# Source
if (BUILD_TESTING)
  include(CTest)
  include(GoogleTest)
endif()
add_subdirectory(templatepp)
#----------------------------------------------------------------------
# Install project commons
file(WRITE ${CMAKE_BINARY_DIR}/VERSION ${PROJECT_VERSION})
install(
  FILES "${CMAKE_BINARY_DIR}/VERSION"
  DESTINATION ${PACKAGE_INSTALL_DOCDIR})
install(
  FILES "${CMAKE_SOURCE_DIR}/README.md"
  DESTINATION ${PACKAGE_INSTALL_DOCDIR})
install(
  FILES "${CMAKE_SOURCE_DIR}/LICENSE"
  DESTINATION ${PACKAGE_INSTALL_DOCDIR})
#----------------------------------------------------------------------
include(export_config)
#----------------------------------------------------------------------
# Archive package
if (BUILD_PACKAGING)
  include(package)
endif()
#----------------------------------------------------------------------
#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#
