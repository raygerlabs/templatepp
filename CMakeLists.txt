#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#
#-------------------------------------------------------------------------------------------------------------------#
cmake_minimum_required(VERSION 3.20)
if (NOT CMAKE_BUILD_TYPE)
  set(CMAKE_BUILD_TYPE Release)
endif()

# Project package information
set(PACKAGE_NAME "templatepp")
set(PACKAGE_VERSION_MAJOR "0")
set(PACKAGE_VERSION_MINOR "2")
set(PACKAGE_VERSION_PATCH "0")
set(PACKAGE_VERSION "${PACKAGE_VERSION_MAJOR}.${PACKAGE_VERSION_MINOR}.${PACKAGE_VERSION_PATCH}")
set(PACKAGE_VENDOR "raygerlabs")

project(${PACKAGE_NAME} VERSION ${PACKAGE_VERSION} LANGUAGES C CXX)

option(BUILD_SHARED_LIBS "Build shared libraries" ON)
option(BUILD_TESTING "Build unit tests" ON)

# Add the build tree 
list(APPEND CMAKE_PREFIX_PATH "${CMAKE_BINARY_DIR}")
list(APPEND CMAKE_MODULE_PATH "${CMAKE_BINARY_DIR}")

# Specify build tree path
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin)
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib)
set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib)
set(CMAKE_DEBUG_POSTFIX "d")
set(CMAKE_RELEASE_POSTFIX "")

# Enforce C++ standard
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

# Enable position independent code
set(CMAKE_POSITION_INDEPENDENT_CODE ON)

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
#-------------------------------------------------------------------------------------------------------------------#
# Add project sources
add_subdirectory(src)
if (BUILD_TESTING)
  include(CTest)
  include(GoogleTest)
  add_subdirectory(tests)
endif()
#-------------------------------------------------------------------------------------------------------------------#
# Initialize CPack by project defaults
# Keep in mind, these variables must be set before include(CPack)!
# Use tar.gz archive files by default, but for Windows generate zip files
if (NOT CPACK_GENERATOR)
  set(CPACK_GENERATOR "TGZ")
  if (WIN32)
    set(CPACK_GENERATOR "ZIP")
  endif()
endif()
set(CPACK_GENERATOR "${PACKAGE_GENERATOR}" CACHE STRING "List of package generators (CPack).")
set(CPACK_SOURCE_GENERATOR "${CPACK_GENERATOR}" CACHE STRING "List of source package generators (CPack).")
mark_as_advanced (CPACK_GENERATOR CPACK_SOURCE_GENERATOR)
set(CPACK_PACKAGE_NAME "${PACKAGE_NAME}")
set(CPACK_PACKAGE_VERSION_MAJOR "${PACKAGE_VERSION_MAJOR}")
set(CPACK_PACKAGE_VERSION_MINOR "${PACKAGE_VERSION_MINOR}")
set(CPACK_PACKAGE_VERSION_PATCH "${PACKAGE_VERSION_PATCH}")
set(CPACK_PACKAGE_VENDOR "${PACKAGE_VENDOR}")
set(CPACK_RESOURCE_FILE_README "${CMAKE_SOURCE_DIR}/README.md")
set(CPACK_RESOURCE_FILE_LICENSE "${CMAKE_SOURCE_DIR}/LICENSE")
set (CPACK_RESOURCE_FILE_WELCOME "${CMAKE_SOURCE_DIR}/README.md")
install(FILES "${CPACK_RESOURCE_FILE_README}" DESTINATION .)
install(FILES "${CPACK_RESOURCE_FILE_LICENSE}" DESTINATION .)
file(WRITE "${CMAKE_BINARY_DIR}/VERSION" "${PACKAGE_VERSION}")
install(FILES "${CMAKE_BINARY_DIR}/VERSION" DESTINATION .)
include(CPack) # cpack_add_component(), cpack_add_component_group() ...
# Generate archive file name and path
set(CPACK_INCLUDE_TOPLEVEL_DIRECTORY TRUE)
if (NOT CPACK_OUTPUT_FILE_PREFIX)
  set(CPACK_OUTPUT_FILE_PREFIX "${CMAKE_BINARY_DIR}")
endif()
if (NOT CPACK_PACKAGE_DIRECTORY)
  set(CPACK_PACKAGE_DIRECTORY "${CMAKE_BINARY_DIR}")
endif()
set (CPACK_PACKAGE_FILE_NAME "${CPACK_PACKAGE_NAME}-${CPACK_PACKAGE_VERSION}-${CPACK_SYSTEM_NAME}")
if (CPACK_PACKAGE_ARCHITECTURE)
  set(CPACK_PACKAGE_FILE_NAME "${CPACK_PACKAGE_FILE_NAME}-${CPACK_PACKAGE_ARCHITECTURE}")
endif()
set(CPACK_SOURCE_PACKAGE_FILE_NAME "${CPACK_PACKAGE_FILE_NAME}-src")
file(WRITE "${CMAKE_BINARY_DIR}/artifact_name.txt" "${CPACK_PACKAGE_FILE_NAME}")
#-------------------------------------------------------------------------------------------------------------------#
#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#
