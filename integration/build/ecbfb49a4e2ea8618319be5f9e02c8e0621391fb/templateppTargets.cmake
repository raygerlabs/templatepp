# Load the debug and release variables
get_filename_component(_DIR "${CMAKE_CURRENT_LIST_FILE}" PATH)
file(GLOB DATA_FILES "${_DIR}/templatepp-*-data.cmake")

foreach(f ${DATA_FILES})
    include(${f})
endforeach()

# Create the targets for all the components
foreach(_COMPONENT ${templatepp_COMPONENT_NAMES} )
    if(NOT TARGET ${_COMPONENT})
        add_library(${_COMPONENT} INTERFACE IMPORTED)
        conan_message(STATUS "Conan: Component target declared '${_COMPONENT}'")
    endif()
endforeach()

if(NOT TARGET templatepp::templatepp)
    add_library(templatepp::templatepp INTERFACE IMPORTED)
    conan_message(STATUS "Conan: Target declared 'templatepp::templatepp'")
endif()
# Load the debug and release library finders
get_filename_component(_DIR "${CMAKE_CURRENT_LIST_FILE}" PATH)
file(GLOB CONFIG_FILES "${_DIR}/templatepp-Target-*.cmake")

foreach(f ${CONFIG_FILES})
    include(${f})
endforeach()