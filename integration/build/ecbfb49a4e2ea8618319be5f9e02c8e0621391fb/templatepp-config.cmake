########## MACROS ###########################################################################
#############################################################################################

# Requires CMake > 3.15
if(${CMAKE_VERSION} VERSION_LESS "3.15")
    message(FATAL_ERROR "The 'CMakeDeps' generator only works with CMake >= 3.15")
endif()


include(${CMAKE_CURRENT_LIST_DIR}/cmakedeps_macros.cmake)
include(${CMAKE_CURRENT_LIST_DIR}/templateppTargets.cmake)
include(CMakeFindDependencyMacro)

foreach(_DEPENDENCY ${templatepp_FIND_DEPENDENCY_NAMES} )
    # Check that we have not already called a find_package with the transitive dependency
    if(NOT ${_DEPENDENCY}_FOUND)
        find_dependency(${_DEPENDENCY} REQUIRED ${${_DEPENDENCY}_FIND_MODE})
    endif()
endforeach()

set(templatepp_VERSION_STRING "0.4.0")
set(templatepp_INCLUDE_DIRS ${templatepp_INCLUDE_DIRS_RELEASE} )
set(templatepp_INCLUDE_DIR ${templatepp_INCLUDE_DIRS_RELEASE} )
set(templatepp_LIBRARIES ${templatepp_LIBRARIES_RELEASE} )
set(templatepp_DEFINITIONS ${templatepp_DEFINITIONS_RELEASE} )

# Only the first installed configuration is included to avoid the collision
foreach(_BUILD_MODULE ${templatepp_BUILD_MODULES_PATHS_RELEASE} )
    conan_message(STATUS "Conan: Including build module from '${_BUILD_MODULE}'")
    include(${_BUILD_MODULE})
endforeach()

