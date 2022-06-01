#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#
#----------------------------------------------------------------------
add_executable(${PACKAGE_NAME}_tests)
target_sources(${PACKAGE_NAME}_tests 
  PRIVATE
    application_test.cpp
)
#----------------------------------------------------------------------
find_package(GTest CONFIG REQUIRED)
target_link_libraries(
  ${PACKAGE_NAME}_tests
    ${PACKAGE_NAME}
    GTest::gtest
    GTest::gtest_main
)
#----------------------------------------------------------------------
set_target_properties(${PACKAGE_NAME}_tests PROPERTIES FOLDER "Tests")
get_target_property(SOURCES ${PACKAGE_NAME}_tests SOURCES)
source_group(TREE ${CMAKE_CURRENT_LIST_DIR} FILES ${SOURCES})
#----------------------------------------------------------------------
gtest_discover_tests(${PACKAGE_NAME}_tests)
#----------------------------------------------------------------------
#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#
