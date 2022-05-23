#---------------------------------------------------------------------#
set(SOURCE_LIST
  application.cpp
)
set(INCLUDE_LIST
  details/configure.hpp
  application.hpp
)
add_library(${PROJECT_NAME})
target_sources(${PROJECT_NAME}
PRIVATE
  ${SOURCE_LIST}
PUBLIC
  FILE_SET HEADERS
    BASE_DIRS
      ${CMAKE_SOURCE_DIR}
    FILES
      ${INCLUDE_LIST}
)
target_compile_definitions(${PROJECT_NAME}
PUBLIC
  $<$<BOOL:${BUILD_SHARED_LIBS}>:RGLABS_DLL=1>
)
target_include_directories(${PROJECT_NAME}
PUBLIC
  $<BUILD_INTERFACE:${CMAKE_CURRENT_LIST_DIR}>
  $<INSTALL_INTERFACE:include>
)
set_target_properties(${PROJECT_NAME}
PROPERTIES
  FOLDER "Runtime"
)
install(TARGETS ${PROJECT_NAME}
  RUNTIME DESTINATION bin
  LIBRARY DESTINATION lib
  ARCHIVE DESTINATION lib
  INCLUDES DESTINATION include
  FILE_SET HEADERS
)
source_group(
TREE
  ${CMAKE_CURRENT_LIST_DIR}
FILES
  ${SOURCE_LIST}
  ${INCLUDE_LIST}
)

# Unit tests
#---------------------------------------------------------------------#
add_executable(${PROJECT_NAME}.test)
target_sources(${PROJECT_NAME}.test
PRIVATE
  application.test.cpp
)
find_package(GTest CONFIG REQUIRED)
target_link_libraries(${PROJECT_NAME}.test
  ${PROJECT_NAME}
  GTest::gtest_main
)
set_target_properties(${PROJECT_NAME}.test
PROPERTIES
  FOLDER "Tests"
)
get_target_property(TEST_LIST ${PROJECT_NAME}.test SOURCES)
source_group(
  TREE
    ${CMAKE_CURRENT_LIST_DIR}
  FILES
    ${TEST_LIST}
)
gtest_discover_tests(${PROJECT_NAME}.test)
#---------------------------------------------------------------------#
