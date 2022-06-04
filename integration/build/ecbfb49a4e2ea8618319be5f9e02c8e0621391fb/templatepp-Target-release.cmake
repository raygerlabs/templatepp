########### VARIABLES #######################################################################
#############################################################################################

set(templatepp_COMPILE_OPTIONS_RELEASE
    "$<$<COMPILE_LANGUAGE:CXX>:${templatepp_COMPILE_OPTIONS_CXX_RELEASE}>"
    "$<$<COMPILE_LANGUAGE:C>:${templatepp_COMPILE_OPTIONS_C_RELEASE}>")

set(templatepp_LINKER_FLAGS_RELEASE
    "$<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${templatepp_SHARED_LINK_FLAGS_RELEASE}>"
    "$<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${templatepp_SHARED_LINK_FLAGS_RELEASE}>"
    "$<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${templatepp_EXE_LINK_FLAGS_RELEASE}>")

set(templatepp_FRAMEWORKS_FOUND_RELEASE "") # Will be filled later
conan_find_apple_frameworks(templatepp_FRAMEWORKS_FOUND_RELEASE "${templatepp_FRAMEWORKS_RELEASE}" "${templatepp_FRAMEWORK_DIRS_RELEASE}")

# Gather all the libraries that should be linked to the targets (do not touch existing variables)
set(_templatepp_DEPENDENCIES_RELEASE "${templatepp_FRAMEWORKS_FOUND_RELEASE} ${templatepp_SYSTEM_LIBS_RELEASE} ")

set(templatepp_LIBRARIES_TARGETS_RELEASE "") # Will be filled later
set(templatepp_LIBRARIES_RELEASE "") # Will be filled later
conan_package_library_targets("${templatepp_LIBS_RELEASE}"    # libraries
                              "${templatepp_LIB_DIRS_RELEASE}" # package_libdir
                              "${_templatepp_DEPENDENCIES_RELEASE}" # deps
                              templatepp_LIBRARIES_RELEASE   # out_libraries
                              templatepp_LIBRARIES_TARGETS_RELEASE  # out_libraries_targets
                              "_RELEASE"  # config_suffix
                              "templatepp")    # package_name

foreach(_FRAMEWORK ${templatepp_FRAMEWORKS_FOUND_RELEASE})
    list(APPEND templatepp_LIBRARIES_TARGETS_RELEASE ${_FRAMEWORK})
    list(APPEND templatepp_LIBRARIES_RELEASE ${_FRAMEWORK})
endforeach()

foreach(_SYSTEM_LIB ${templatepp_SYSTEM_LIBS_RELEASE})
    list(APPEND templatepp_LIBRARIES_TARGETS_RELEASE ${_SYSTEM_LIB})
    list(APPEND templatepp_LIBRARIES_RELEASE ${_SYSTEM_LIB})
endforeach()

# We need to add our requirements too
set(templatepp_LIBRARIES_TARGETS_RELEASE "${templatepp_LIBRARIES_TARGETS_RELEASE};")
set(templatepp_LIBRARIES_RELEASE "${templatepp_LIBRARIES_RELEASE};")

# FIXME: What is the result of this for multi-config? All configs adding themselves to path?
set(CMAKE_MODULE_PATH ${templatepp_BUILD_DIRS_RELEASE} ${CMAKE_MODULE_PATH})
set(CMAKE_PREFIX_PATH ${templatepp_BUILD_DIRS_RELEASE} ${CMAKE_PREFIX_PATH})


########## GLOBAL TARGET PROPERTIES Release ########################################
set_property(TARGET templatepp::templatepp
             PROPERTY INTERFACE_LINK_LIBRARIES
             $<$<CONFIG:Release>:${templatepp_LIBRARIES_TARGETS_RELEASE}
                                           ${templatepp_OBJECTS_RELEASE}> APPEND)

set_property(TARGET templatepp::templatepp
             PROPERTY INTERFACE_LINK_OPTIONS
             $<$<CONFIG:Release>:${templatepp_LINKER_FLAGS_RELEASE}> APPEND)
set_property(TARGET templatepp::templatepp
             PROPERTY INTERFACE_INCLUDE_DIRECTORIES
             $<$<CONFIG:Release>:${templatepp_INCLUDE_DIRS_RELEASE}> APPEND)
set_property(TARGET templatepp::templatepp
             PROPERTY INTERFACE_COMPILE_DEFINITIONS
             $<$<CONFIG:Release>:${templatepp_COMPILE_DEFINITIONS_RELEASE}> APPEND)
set_property(TARGET templatepp::templatepp
             PROPERTY INTERFACE_COMPILE_OPTIONS
             $<$<CONFIG:Release>:${templatepp_COMPILE_OPTIONS_RELEASE}> APPEND)########## COMPONENTS TARGET PROPERTIES Release ########################################
