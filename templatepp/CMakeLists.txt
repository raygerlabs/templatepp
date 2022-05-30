#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#
### Build rules
set(TARGET_NAME templatepp)
string(TOUPPER ${TARGET_NAME} PACKAGE_PREFIX)
set(EXPORT_NAME ${TARGET_NAME}-targets)

add_library(${TARGET_NAME})
target_sources(${TARGET_NAME}
  PRIVATE
    application.cpp
  PUBLIC INTERFACE
    FILE_SET HEADERS
      BASE_DIRS
        ${CMAKE_CURRENT_LIST_DIR}
      FILES
        application.hpp
        details/config.hpp
)
target_include_directories(${TARGET_NAME}
  PUBLIC
    $<BUILD_INTERFACE:${CMAKE_CURRENT_LIST_DIR}>
    $<INSTALL_INTERFACE:${INCLUDE_INSTALL_DIR}>
)
set_target_properties(${TARGET_NAME} PROPERTIES FOLDER "Libraries")
get_target_property(SOURCES_LIST ${TARGET_NAME} SOURCES)
get_target_property(HEADERS_LIST ${TARGET_NAME} HEADER_SET_${TARGET_NAME})
source_group(TREE ${CMAKE_CURRENT_LIST_DIR} FILES ${SOURCES_LIST} ${HEADERS_LIST})
#--------------------------------------------------------------------------------------------------------------------
### Installation rules
install(
  TARGETS ${TARGET_NAME}
  EXPORT ${EXPORT_NAME}
  RUNTIME DESTINATION ${BIN_INSTALL_DIR}
  LIBRARY DESTINATION ${LIB_INSTALL_DIR}
  ARCHIVE DESTINATION ${LIB_INSTALL_DIR}
  INCLUDES DESTINATION ${INCLUDE_INSTALL_DIR}
  FILE_SET HEADERS
)

# Add the current target to the build-tree export set
export(TARGETS ${TARGET_NAME} FILE "${PROJECT_BINARY_DIR}/${EXPORT_NAME}.cmake")

# Export the current target for use from the build-tree
# (this registers the build-tree with a global CMake-registry)
export(PACKAGE ${TARGET_NAME})

# Generate both config files
file(RELATIVE_PATH RELATIVE_INCLUDE_DIR "${CONFIG_INSTALL_DIR}" "${INCLUDE_INSTALL_DIR}")

# ... for the build tree
set(CONFIG_INCLUDE_DIRS "${PROJECT_SOURCE_DIR}" "${PROJECT_BINARY_DIR}")
configure_file(
  ${CMAKE_SOURCE_DIR}/cmake/config/config.cmake.in
  ${PROJECT_BINARY_DIR}/${TARGET_NAME}-config.cmake
  @ONLY
)

# ... for the install tree
set(CONFIG_INCLUDE_DIRS "${${TARGET_NAME}_CMAKE_DIR}/${RELATIVE_INCLUDE_DIR}/${PROJECT_NAME}")
configure_file(
  ${CMAKE_SOURCE_DIR}/cmake/config/config.cmake.in
  ${PROJECT_BINARY_DIR}${CMAKE_FILES_DIRECTORY}/${TARGET_NAME}-config.cmake
  @ONLY
)

# ... for both
configure_file(
  ${CMAKE_SOURCE_DIR}/cmake/config/version.cmake.in
  ${PROJECT_BINARY_DIR}/${TARGET_NAME}-config-version.cmake
  @ONLY
)

# Install generated config files
install(FILES
  ${PROJECT_BINARY_DIR}${CMAKE_FILES_DIRECTORY}/${TARGET_NAME}-config.cmake
  ${PROJECT_BINARY_DIR}/${TARGET_NAME}-config-version.cmake
  DESTINATION ${CONFIG_INSTALL_DIR}
)

# Install the export set for use with the install-tree
install(EXPORT ${TARGET_NAME}-targets DESTINATION ${CONFIG_INSTALL_DIR})

#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#
### Unit tests
if (BUILD_TESTING)
  set(TEST_NAME ${TARGET_NAME}-tests)
  add_executable(${TEST_NAME})
  target_sources(${TEST_NAME}
    PRIVATE
      application.tests.cpp
  )
  target_include_directories(${TEST_NAME}
  PRIVATE
    ${CMAKE_CURRENT_LIST_DIR}
  )
  find_package(GTest CONFIG REQUIRED)
  target_link_libraries(${TEST_NAME} ${TARGET_NAME} GTest::gtest GTest::gtest_main)
  set_target_properties(${TEST_NAME} PROPERTIES FOLDER "Tests")
  get_target_property(TESTS_LIST ${TEST_NAME} SOURCES)
  source_group(TREE ${CMAKE_CURRENT_LIST_DIR} FILES ${TESTS_LIST})
  gtest_discover_tests(${TEST_NAME})
endif()
#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#