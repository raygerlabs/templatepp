#---------------------------------------------------------------------#
add_library(${PROJECT_NAME})

list(APPEND SOURCE_LIST
  application.cpp
)
list(APPEND HEADER_LIST
  ../include/${PROJECT_NAME}/details/configure.hpp
  ../include/${PROJECT_NAME}/application.hpp
)
target_sources(${PROJECT_NAME}
  PRIVATE
    ${SOURCE_LIST}
  PUBLIC
    FILE_SET HEADERS
      BASE_DIRS
        ${CMAKE_SOURCE_DIR}
      FILES
        ${HEADER_LIST}
)
#---------------------------------------------------------------------#
target_compile_definitions(${PROJECT_NAME}
  PUBLIC
    $<$<BOOL:${BUILD_SHARED_LIBS}>:RGLABS_DLL=1>
)
#---------------------------------------------------------------------#
target_include_directories(${PROJECT_NAME}
  PUBLIC
    $<BUILD_INTERFACE:${CMAKE_SOURCE_DIR}/include/${PROJECT_NAME}>
    $<INSTALL_INTERFACE:include>
  PRIVATE
    $<BUILD_INTERFACE:${CMAKE_CURRENT_LIST_DIR}>
)
#---------------------------------------------------------------------#
set_target_properties(${PROJECT_NAME} PROPERTIES FOLDER "Runtime")
source_group(TREE ${CMAKE_SOURCE_DIR} FILES ${SOURCE_LIST})
source_group(TREE ${CMAKE_SOURCE_DIR} FILES ${HEADER_LIST})
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
  FILE_SET
    HEADERS
  COMPONENT
    ${PROJECT_NAME}
)
#---------------------------------------------------------------------#
cpack_add_component(${PROJECT_NAME})
#---------------------------------------------------------------------#
