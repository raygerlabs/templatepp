cmake_minimum_required(VERSION 3.23 FATAL_ERROR)
project(integration_test)
add_executable(${PROJECT_NAME})
target_sources(${PROJECT_NAME}
  PRIVATE
    ${CMAKE_CURRENT_SOURCE_DIR}/integration_test.cpp
)
find_package(templatepp REQUIRED)
target_link_libraries(${PROJECT_NAME}
  PRIVATE
    templatepp::templatepp
)
