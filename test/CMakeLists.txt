#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#
#------------------------------------------------------------------------------
add_executable(unit_tests)
#------------------------------------------------------------------------------
target_sources(unit_tests
PRIVATE
  application_test.cpp
)
#------------------------------------------------------------------------------
find_package(GTest CONFIG REQUIRED)
target_link_libraries(unit_tests
  GTest::gtest
  GTest::gtest_main
  templatepp
)
#------------------------------------------------------------------------------
set_target_properties(unit_tests PROPERTIES FOLDER "Tests")
get_target_property(TESTS unit_tests SOURCES)
source_group(TREE ${CMAKE_CURRENT_LIST_DIR} FILES ${TESTS})
#------------------------------------------------------------------------------
gtest_discover_tests(unit_tests)
#------------------------------------------------------------------------------
#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#
