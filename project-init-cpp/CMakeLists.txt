#---------------------------------------------------------------------#
set(SOURCE_FILE_LIST
  application.cpp
)
set(INCLUDE_FILE_LIST
  details/configure.hpp
  application.hpp
)
add_library(${PROJECT_NAME})
target_sources(${PROJECT_NAME}
PRIVATE
  ${SOURCE_FILE_LIST}
PUBLIC
  FILE_SET HEADERS
    BASE_DIRS
      ${CMAKE_SOURCE_DIR}
    FILES
      ${INCLUDE_FILE_LIST}
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
  ${SOURCE_FILE_LIST}
  ${INCLUDE_FILE_LIST}
)

# Unit tests
#---------------------------------------------------------------------#
if (BUILD_TESTING)
  set(TEST_PROJECT_NAME "${PROJECT_NAME}.test")
  set(TEST_FILE_LIST
    application.test.cpp
  )
  add_executable(${TEST_PROJECT_NAME})
  target_sources(${TEST_PROJECT_NAME}
  PRIVATE
    ${TEST_FILE_LIST}
  )
  find_package(GTest CONFIG REQUIRED)
  target_link_libraries(${TEST_PROJECT_NAME}
    ${PROJECT_NAME}
    GTest::gtest_main
  )
  set_target_properties(${TEST_PROJECT_NAME}
  PROPERTIES
    FOLDER "Tests"
  )
  source_group(
    TREE
      ${CMAKE_CURRENT_LIST_DIR}
    FILES
      ${TEST_FILE_LIST}
  )
  gtest_discover_tests(${TEST_PROJECT_NAME})
endif(BUILD_TESTING)
#---------------------------------------------------------------------#
