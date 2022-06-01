#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#
#----------------------------------------------------------------------
add_library(${PACKAGE_NAME})
#----------------------------------------------------------------------
configure_file("config.hpp.in"
  "${PROJECT_BINARY_DIR}/include/${PACKAGE_NAME}/config.hpp"
)
configure_file("version.hpp.in"
  "${PROJECT_BINARY_DIR}/include/${PACKAGE_NAME}/version.hpp"
)
#----------------------------------------------------------------------
target_sources(
  ${PACKAGE_NAME}
    PRIVATE
      application.cpp
    PUBLIC
      FILE_SET HEADERS
        BASE_DIRS
          ${PROJECT_SOURCE_DIR}/include/${PACKAGE_NAME}
          ${PROJECT_BINARY_DIR}/include/${PACKAGE_NAME}
        FILES
          ../include/${PACKAGE_NAME}/application.hpp
          ../build/include/${PACKAGE_NAME}/config.hpp
          ../build/include/${PACKAGE_NAME}/version.hpp
)
#----------------------------------------------------------------------
target_include_directories(
  ${PACKAGE_NAME}
    PUBLIC
      $<BUILD_INTERFACE:${PROJECT_SOURCE_DIR}/include/${PACKAGE_NAME}>
      $<BUILD_INTERFACE:${PROJECT_BINARY_DIR}/include/${PACKAGE_NAME}>
      $<INSTALL_INTERFACE:include>
    PRIVATE
      ${CMAKE_CURRENT_LIST_DIR}
)
#----------------------------------------------------------------------
set_target_properties(
  ${PACKAGE_NAME}
    PROPERTIES
      FOLDER "Runtime"
)
get_target_property(
  SOURCES
    ${PACKAGE_NAME}
      SOURCES
)
get_target_property(
  HEADERS
    ${PACKAGE_NAME}
      HEADER_SET_${PACKAGE_NAME}
)
source_group(TREE ${CMAKE_SOURCE_DIR} FILES ${SOURCES} ${HEADERS})
#----------------------------------------------------------------------
install(
  TARGETS
    ${PACKAGE_NAME}
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
#----------------------------------------------------------------------
