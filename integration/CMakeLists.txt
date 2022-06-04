#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#
#----------------------------------------------------------------------
cmake_minimum_required(VERSION 3.23 FATAL_ERROR)
#----------------------------------------------------------------------
if (NOT CMAKE_BUILD_TYPE)
  set(CMAKE_BUILD_TYPE Release)
endif()
list(APPEND CMAKE_PREFIX_PATH ${CMAKE_BINARY_DIR})
list(APPEND CMAKE_MODULE_PATH ${CMAKE_BINARY_DIR})
list(APPEND CMAKE_MODULE_PATH ${CMAKE_SOURCE_DIR}/../cmake)
#----------------------------------------------------------------------
project(integration VERSION 0.4.0)
#----------------------------------------------------------------------
include(build_options)
include(build_paths)
include(install_paths)
#---INTEGRATION TEST---------------------------------------------------
add_executable(integration)
target_sources(integration PRIVATE integration.cpp)
find_package(templatepp CONFIG REQUIRED)
target_link_libraries(integration templatepp::templatepp)
set_target_properties(integration PROPERTIES FOLDER "Tests")
get_target_property(SOURCES integration SOURCES)
source_group(TREE ${CMAKE_CURRENT_LIST_DIR} FILES ${SOURCES})
#----------------------------------------------------------------------
#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#
