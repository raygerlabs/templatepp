#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#
#-------------------------------------------------------------------------------------------------------------------#
list(APPEND SOURCE_LIST
  "application.cpp"
)
list(APPEND HEADER_LIST
  "../include/${PROJECT_NAME}/details/configure.hpp"
  "../include/${PROJECT_NAME}/application.hpp"
)
add_library(templatepp)
target_sources(templatepp
  PRIVATE
    "${SOURCE_LIST}"
  PUBLIC
    FILE_SET HEADERS
      BASE_DIRS
        "${CMAKE_SOURCE_DIR}"
      FILES
        "${HEADER_LIST}"
)
#-------------------------------------------------------------------------------------------------------------------#
target_compile_definitions(templatepp
  PUBLIC
    "$<$<BOOL:${BUILD_SHARED_LIBS}>:TEMPLATEPP_DLL=1>"
)
target_include_directories(templatepp
  PUBLIC
    "$<BUILD_INTERFACE:${CMAKE_SOURCE_DIR}/include/${PROJECT_NAME}>"
    "$<INSTALL_INTERFACE:include>"
  PRIVATE
    "$<BUILD_INTERFACE:${CMAKE_CURRENT_LIST_DIR}>"
)
set_target_properties(templatepp PROPERTIES FOLDER "Runtime")
source_group(TREE "${CMAKE_SOURCE_DIR}" FILES "${SOURCE_LIST}" "${HEADER_LIST}")
install(TARGETS templatepp
  RUNTIME DESTINATION "bin"
  LIBRARY DESTINATION "lib"
  ARCHIVE DESTINATION "lib"
  INCLUDES DESTINATION "include"
  FILE_SET HEADERS
)
#-------------------------------------------------------------------------------------------------------------------#
#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#
