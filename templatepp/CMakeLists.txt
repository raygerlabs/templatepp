#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#
#--- COMPONENT --------------------------------------------------------
set(_TARGET ${PROJECT_NAME})
add_library(${_TARGET})
configure_file(
  config.hpp.in
  ${PROJECT_BINARY_DIR}/${_TARGET}/config.hpp
  @ONLY)
configure_file(
  version.hpp.in
  ${PROJECT_BINARY_DIR}/${_TARGET}/version.hpp
  @ONLY)
target_sources(${_TARGET}
  PRIVATE
    application.cpp
  PUBLIC INTERFACE
    FILE_SET HEADERS
      BASE_DIRS
        ${PROJECT_SOURCE_DIR}/${_TARGET}
        ${PROJECT_BINARY_DIR}/${_TARGET}
      FILES
        ${PROJECT_BINARY_DIR}/${_TARGET}/config.hpp
        ${PROJECT_BINARY_DIR}/${_TARGET}/version.hpp
        ${PROJECT_SOURCE_DIR}/${_TARGET}/application.hpp
)

target_include_directories(${_TARGET}
  PUBLIC
    $<BUILD_INTERFACE:${PROJECT_SOURCE_DIR}/${_TARGET}>
    $<BUILD_INTERFACE:${PROJECT_BINARY_DIR}/${_TARGET}>
    $<INSTALL_INTERFACE:${PACKAGE_INSTALL_INCLUDEDIR}>
  PRIVATE
    ${CMAKE_CURRENT_LIST_DIR}
)

set_target_properties(${_TARGET} PROPERTIES FOLDER "Runtime")
get_target_property(SOURCES ${_TARGET} SOURCES)
get_target_property(INCLUDES ${_TARGET} HEADER_SET_${_TARGET})
source_group(TREE ${CMAKE_SOURCE_DIR} FILES ${SOURCES} ${INCLUDES})

install(
  TARGETS ${_TARGET}
  EXPORT ${PROJECT_NAME}-targets
  RUNTIME DESTINATION ${PACKAGE_INSTALL_BINDIR}
  LIBRARY DESTINATION ${PACKAGE_INSTALL_LIBDIR}
  ARCHIVE DESTINATION ${PACKAGE_INSTALL_LIBDIR}
  INCLUDES DESTINATION ${PACKAGE_INSTALL_INCLUDEDIR}
  FILE_SET HEADERS
)
export (
  TARGETS ${_TARGET}
  NAMESPACE ${PROJECT_NAME}::
  FILE ${PROJECT_BINARY_DIR}/${PROJECT_NAME}-targets.cmake
)
#--- UNIT TESTS -------------------------------------------------------
if (BUILD_TESTING)
add_executable(${_TARGET}_tests)
target_sources(${_TARGET}_tests
PRIVATE
  application.test.cpp
)
find_package(GTest CONFIG REQUIRED)
target_link_libraries(${_TARGET}_tests
  GTest::gtest
  GTest::gtest_main
  ${_TARGET}
)
set_target_properties(${_TARGET}_tests PROPERTIES FOLDER "Tests")
get_target_property(TESTS ${_TARGET}_tests SOURCES)
source_group(TREE ${CMAKE_CURRENT_LIST_DIR} FILES ${TESTS})
gtest_discover_tests(${_TARGET}_tests)
endif()
#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#
