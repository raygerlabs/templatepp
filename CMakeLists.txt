#---------------------------------------------------------------------#
cmake_minimum_required(VERSION 3.20)
project(project_init_cpp VERSION 0.2.0)
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
install(FILES "${CMAKE_SOURCE_DIR}/README.md" DESTINATION .)
install(FILES "${CMAKE_SOURCE_DIR}/LICENSE.txt" DESTINATION .)
#---------------------------------------------------------------------#
# NOTE: These variables must be set BEFORE including cpack!
set(CPACK_PACKAGE_NAME "${PROJECT_NAME}")
set(CPACK_PACKAGE_VERSION "${PROJECT_VERSION}")
set(CPACK_RESOURCE_FILE_README "${CMAKE_SOURCE_DIR}/README.md")
set(CPACK_RESOURCE_FILE_LICENSE "${CMAKE_SOURCE_DIR}/LICENSE.txt")

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
