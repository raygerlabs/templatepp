#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#
#----------------------------------------------------------------------
cmake_minimum_required(VERSION 3.23)
#----------------------------------------------------------------------
# Package information
set(PACKAGE_NAME           "templatepp")
set(PACKAGE_VERSION_MAJOR  0)
set(PACKAGE_VERSION_MINOR  3)
set(PACKAGE_VERSION_PATCH  0)
set(PACKAGE_VERSION        ${PACKAGE_VERSION_MAJOR})
set(PACKAGE_VERSION        ${PACKAGE_VERSION}.${PACKAGE_VERSION_MINOR})
set(PACKAGE_VERSION        ${PACKAGE_VERSION}.${PACKAGE_VERSION_PATCH})
set(PACKAGE_DESCRIPTION    "Cross-platform project template for C/C++")
set(PACKAGE_VENDOR         "raygerlabs")
set(PACKAGE_URL            "https://github.com/raygerlabs/templatepp")
#----------------------------------------------------------------------
project(${PACKAGE_NAME} VERSION ${PACKAGE_VERSION} LANGUAGES C CXX)
#----------------------------------------------------------------------
option(BUILD_SHARED_LIBS   "Build shared libraries"      ON)
option(BUILD_TESTING       "Build unit tests"            ON)
option(BUILD_PACKAGING     "Build distribution packages" ON)
#----------------------------------------------------------------------
set(PACKAGE_DLL 0)
if (BUILD_SHARED_LIBS)
  set(PACKAGE_DLL 1)
endif()
string(TOUPPER "${PACKAGE_NAME}" PACKAGE_PREFIX)
#----------------------------------------------------------------------
# Add conan path to the cmake build tree
list(APPEND CMAKE_PREFIX_PATH ${CMAKE_BINARY_DIR})
list(APPEND CMAKE_MODULE_PATH ${CMAKE_BINARY_DIR})
# Add cmake util path to the cmake build tree
list(APPEND CMAKE_MODULE_PATH ${CMAKE_SOURCE_DIR}/cmake)
#----------------------------------------------------------------------
# Build paths
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin)
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib)
set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib)
#----------------------------------------------------------------------
# Enable IDE folders (eg. Visual Studio, Xcode...)
set_property(GLOBAL PROPERTY USE_FOLDERS ON)
#----------------------------------------------------------------------
# Common build options
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)
set(CMAKE_POSITION_INDEPENDENT_CODE ON)
set(CMAKE_CXX_VISIBILITY_PRESET hidden)
set(CMAKE_VISIBILITY_INLINES_HIDDEN ON)
#----------------------------------------------------------------------
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)
set(CMAKE_VERBOSE_MAKEFILE ON)
set(CMAKE_RULE_MESSAGES OFF)
#----------------------------------------------------------------------
# Source
add_subdirectory(src)
if (BUILD_TESTING)
  include(CTest)
  include(GoogleTest)
  add_subdirectory(tests)
endif()
#----------------------------------------------------------------------
# Install project commons
file(WRITE ${PROJECT_BINARY_DIR}/VERSION ${PACKAGE_VERSION})
install(FILES "${PROJECT_BINARY_DIR}/VERSION" DESTINATION .)
install(FILES "${CMAKE_SOURCE_DIR}/README.md" DESTINATION .)
install(FILES "${CMAKE_SOURCE_DIR}/LICENSE" DESTINATION .)
#----------------------------------------------------------------------
# Package project
include(package)
#----------------------------------------------------------------------
#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#
