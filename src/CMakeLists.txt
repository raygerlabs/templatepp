#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#
#----------------------------------------------------------------------
add_library(templatepp)
#----------------------------------------------------------------------
configure_file(
  config.hpp.in
  ${PROJECT_BINARY_DIR}/include/templatepp/config.hpp
  @ONLY)
configure_file(
  version.hpp.in
  ${PROJECT_BINARY_DIR}/include/templatepp/version.hpp
  @ONLY)
target_sources(templatepp
  PRIVATE
    application.cpp
  PUBLIC INTERFACE
    FILE_SET HEADERS
      BASE_DIRS
        ${PROJECT_SOURCE_DIR}/include
        ${PROJECT_BINARY_DIR}/include
      FILES
        ${PROJECT_BINARY_DIR}/include/templatepp/config.hpp
        ${PROJECT_BINARY_DIR}/include/templatepp/version.hpp
        ${PROJECT_SOURCE_DIR}/include/templatepp/application.hpp
        ${PROJECT_SOURCE_DIR}/include/templatepp/sdl_utils.hpp
)
#----------------------------------------------------------------------
target_include_directories(templatepp
  PUBLIC
    $<BUILD_INTERFACE:${PROJECT_SOURCE_DIR}/include/>
    $<BUILD_INTERFACE:${PROJECT_BINARY_DIR}/include/>
    $<INSTALL_INTERFACE:${PACKAGE_INSTALL_INCLUDEDIR}>
  PRIVATE
    ${CMAKE_CURRENT_LIST_DIR}
)
#----------------------------------------------------------------------
find_package(SDL2 CONFIG REQUIRED)
target_compile_options(templatepp PUBLIC -Umain)
target_link_libraries(templatepp
  SDL2::SDL2
)
#----------------------------------------------------------------------
set_target_properties(templatepp PROPERTIES FOLDER "Runtime")
get_target_property(SOURCES templatepp SOURCES)
get_target_property(INCLUDES templatepp HEADER_SET_TEMPLATEPP)
source_group(TREE ${CMAKE_SOURCE_DIR} FILES ${SOURCES} ${INCLUDES})
#----------------------------------------------------------------------
install(
  TARGETS templatepp
  EXPORT templatepp-targets
  RUNTIME DESTINATION ${PACKAGE_INSTALL_BINDIR}
  LIBRARY DESTINATION ${PACKAGE_INSTALL_LIBDIR}
  ARCHIVE DESTINATION ${PACKAGE_INSTALL_LIBDIR}
  INCLUDES DESTINATION ${PACKAGE_INSTALL_INCLUDEDIR}
  FILE_SET HEADERS
)
export(
  TARGETS templatepp
  NAMESPACE ${PROJECT_NAME}::
  FILE ${PROJECT_BINARY_DIR}/${PROJECT_NAME}-targets.cmake
)
#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#
