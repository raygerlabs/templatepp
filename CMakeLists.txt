#---------------------------------------------------------------------#
cmake_minimum_required(VERSION 3.20)
project(project-init-cpp VERSION 0.2.0)
#---------------------------------------------------------------------#
if (NOT CMAKE_BUILD_TYPE)
  set(CMAKE_BUILD_TYPE Release)
endif()
option(BUILD_SHARED_LIBS "Build shared libraries" ON)
option(BUILD_TESTING "Build unit tests" ON)
#---------------------------------------------------------------------#
set(CMAKE_VERBOSE_MAKEFILE ON)
set(CMAKE_SUPPRESS_REGENERATION ON)
#---------------------------------------------------------------------#
list(APPEND CMAKE_PREFIX_PATH ${CMAKE_BINARY_DIR})
list(APPEND CMAKE_MODULE_PATH ${CMAKE_BINARY_DIR})
#---------------------------------------------------------------------#
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin)
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib)
set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib)
#---------------------------------------------------------------------#
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)
set(CMAKE_POSITION_INDEPENDENT_CODE ON)
set(CMAKE_CXX_VISIBILITY_PRESET hidden)
set(CMAKE_VISIBILITY_INLINES_HIDDEN ON)
set_property(GLOBAL PROPERTY USE_FOLDERS ON)
#---------------------------------------------------------------------#
file(WRITE "${CMAKE_BINARY_DIR}/VERSION" "${PROJECT_VERSION}")
install(FILES "${CMAKE_BINARY_DIR}/VERSION" DESTINATION .)
install(FILES "${CMAKE_SOURCE_DIR}/README.md" DESTINATION .)
install(FILES "${CMAKE_SOURCE_DIR}/LICENSE" DESTINATION .)
#---------------------------------------------------------------------#
# NOTE: These variables must be set BEFORE including cpack!
set(artifact_name "${PROJECT_NAME}")
set(artifact_name "${artifact_name}-v${PROJECT_VERSION}")
set(artifact_name "${artifact_name}-${CMAKE_SYSTEM_NAME}")
set(artifact_name "${artifact_name}-${CMAKE_SYSTEM_PROCESSOR}")
string(TOLOWER "${artifact_name}" artifact_name)
set(artifact_path "${CMAKE_BINARY_DIR}")

set(CPACK_PACKAGE_FILE_NAME "${artifact_name}")
set(CPACK_SOURCE_PACKAGE_FILE_NAME "${artifact_name}-src")
set(CPACK_PACKAGE_VERSION "${CMAKE_BINARY_DIR}/VERSION")
set(CPACK_RESOURCE_FILE_README "${CMAKE_SOURCE_DIR}/README.md")
set(CPACK_RESOURCE_FILE_LICENSE "${CMAKE_SOURCE_DIR}/LICENSE")

set(artifact_type TGZ)
set(artifact_extension "tar.gz")
if(WIN32)
  set(artifact_type ZIP)
  set(artifact_extension "zip")
endif()
set(CPACK_GENERATOR "${artifact_type}")
set(CPACK_SOURCE_GENERATOR "${artifact_type}")

set(CPACK_OUTPUT_FILE_PREFIX "${artifact_path}")
set(CPACK_PACKAGE_DIRECTORY "${artifact_path}")

# Generate artifact information for github actions to pick up
# Currently it is the only way to avoid hard-coded names and paths
set(artifact_name "${artifact_name}.${artifact_extension}")
set(artifact_path "${artifact_path}/${artifact_name}")
file(WRITE "${CMAKE_BINARY_DIR}/artifact_name.txt" "${artifact_name}")
file(WRITE "${CMAKE_BINARY_DIR}/artifact_path.txt" "${artifact_path}")

include(CPack) # cpack_add_component(), cpack_add_component_group() ...
#---------------------------------------------------------------------#
# NOTE: Project modules must be after including cpack if you want to
# use the functionality provided by cpack!
add_subdirectory(src)

include(CTest)
if (BUILD_TESTING)
  include(GoogleTest)
  add_subdirectory(tests)
endif()
#---------------------------------------------------------------------#
