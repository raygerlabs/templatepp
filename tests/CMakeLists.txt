#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#
#-------------------------------------------------------------------------------------------------------------------#
list(APPEND SOURCE_LIST
  "application_test.cpp"
  "main.cpp"
)
add_executable(unit_tests)
target_sources(unit_tests
  PRIVATE
    "${SOURCE_LIST}"
)
#-------------------------------------------------------------------------------------------------------------------#
find_package(GTest CONFIG REQUIRED)
target_link_libraries(unit_tests templatepp GTest::gtest)
set_target_properties(unit_tests PROPERTIES FOLDER "Tests")
get_target_property(SOURCE_LIST unit_tests SOURCES)
source_group(TREE "${CMAKE_CURRENT_LIST_DIR}" FILES "${SOURCE_LIST}")
gtest_discover_tests(unit_tests)
#-------------------------------------------------------------------------------------------------------------------#
#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#
