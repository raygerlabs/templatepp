#---------------------------------------------------------------------#
add_executable(${PROJECT_NAME}-tests)
target_sources(${PROJECT_NAME}-tests 
  PRIVATE
    application_test.cpp
    main.cpp
)
#---------------------------------------------------------------------#
find_package(GTest CONFIG REQUIRED)
target_link_libraries(${PROJECT_NAME}-tests
  ${PROJECT_NAME}
  GTest::gtest
)
#---------------------------------------------------------------------#
set_target_properties(${PROJECT_NAME}-tests
  PROPERTIES
    FOLDER "Tests"
)
get_target_property(SOURCE_LIST
  ${PROJECT_NAME}-tests
    SOURCES
)
source_group(
  TREE
    ${CMAKE_CURRENT_LIST_DIR}
  FILES
    ${SOURCE_LIST}
)
set_property(TEST ${PROJECT_NAME}-tests
  PROPERTY
  ENVIRONMENT
    "DYLD_LIBRARY_PATH=${CMAKE_BINARY_DIR}/lib"
)
#---------------------------------------------------------------------#
gtest_discover_tests(${PROJECT_NAME}-tests)
#---------------------------------------------------------------------#
