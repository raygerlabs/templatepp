#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#
add_library(${PROJECT_NAME})
set(HEADER_LIST
  application.hpp
  details/configure.hpp
)
set(SOURCE_LIST
  application.cpp
)
target_sources(${PROJECT_NAME}
  PUBLIC
    FILE_SET HEADERS
      BASE_DIRS
        ${CMAKE_SOURCE_DIR}
      FILES
        ${HEADER_LIST}
  PRIVATE
    ${SOURCE_LIST}
)
#---------------------------------------------------------------------#
target_compile_definitions(${PROJECT_NAME}
  PUBLIC
    $<$<BOOL:${BUILD_SHARED_LIBS}>:RGLABS_DLL=1>
)
#---------------------------------------------------------------------#
target_include_directories(${PROJECT_NAME}
  PUBLIC
    $<BUILD_INTERFACE:${CMAKE_CURRENT_LIST_DIR}>
    $<INSTALL_INTERFACE:include>
)
#---------------------------------------------------------------------#
source_group(TREE ${CMAKE_SOURCE_DIR} FILES ${HEADER_LIST})
source_group(TREE ${CMAKE_SOURCE_DIR} FILES ${SOURCE_LIST})
#---------------------------------------------------------------------#
install(TARGETS ${PROJECT_NAME}
  RUNTIME DESTINATION
    bin
  LIBRARY DESTINATION
    lib
  ARCHIVE DESTINATION
    lib
  INCLUDES DESTINATION
    include
  FILE_SET HEADERS
)
#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#
#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#
if (BUILD_TESTING)
  include(GoogleTest)
  add_executable(${PROJECT_NAME}-tests)
  target_sources(${PROJECT_NAME}-tests 
    PRIVATE
      application.test.cpp
  )
#---------------------------------------------------------------------#
  find_package(GTest CONFIG REQUIRED)
  target_link_libraries(${PROJECT_NAME}-tests
    ${PROJECT_NAME}
    GTest::gtest_main
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
      ${CMAKE_SOURCE_DIR}
    FILES
      ${SOURCE_LIST}
)
#---------------------------------------------------------------------#
  gtest_discover_tests(${PROJECT_NAME}-tests)
endif()
#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#
