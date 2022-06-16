#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#

# Apply clang-format on a specific CMake target
function(add_clang_format _target_name)
  # Check correct usage of this function
  if (NOT TARGET ${_target_name})
    message(FATAL_ERROR "function 'add_clang_format' called on non-target"
                        "(got ${_target_name})")
  endif ()

  # Check whether to enable lint or if supported at all
  if (NOT ENABLE_LINT OR NOT CMAKE_CXX_COMPILER_ID MATCHES "GNU|Clang")
    return()
  endif()

  # Detect clang-format
  find_program(CLANGFORMAT_PROGRAM NAMES "clang-format")
  if (CLANGFORMAT_PROGRAM-NOTFOUND)
    message(FATAL_ERROR "No clang-format available!")
  endif()

  # figure out which sources this should be applied to
  get_target_property(_target_sources ${_target_name} SOURCES)
  get_target_property(_target_bindir ${_target_name} BINARY_DIR)
  
  # Gather source files of the target
  set(_sources "")
  foreach (_source ${_target_sources})
    if (NOT TARGET ${_source})
      get_filename_component(_source_file ${_source} NAME)
      get_source_file_property(_clang_loc "${_source}" LOCATION)
      set(_format_file ${_target_name}_${_source_file}.format)
      add_custom_command(
        OUTPUT ${_format_file}
        DEPENDS ${_source}
        COMMENT "clang-format: ${_source}"
        COMMAND ${CLANGFORMAT_PROGRAM}
          -style=file
          -fallback-style=WebKit
          -sort-includes
          -i ${_clang_loc}
        COMMAND ${CMAKE_COMMAND} -E touch ${_format_file})
        list(APPEND _sources ${_format_file})
    endif ()
  endforeach ()

  # Create a new CMake target for executing clang-format
  if (_sources)
    add_custom_target(${_target_name}_clangformat
      SOURCES ${_sources}
      COMMENT "clang-format: ${_target_name}")
    # Add clang-format to the target
    add_dependencies(${_target_name} ${_target_name}_clangformat)
  endif ()
endfunction()

# Apply clang-tidy on a specific CMake target
function(add_clang_tidy _target_name)
  # Check the correct usage of this function
  if (NOT TARGET ${_target_name})
    message(FATAL_ERROR "function 'add_clang_tidy' called on non-target"
                        "(got ${_target_name})")
  endif ()
  
  # Check whether to enable lint or if supported at all
  if (NOT ENABLE_LINT OR NOT CMAKE_CXX_COMPILER_ID MATCHES "GNU|Clang")
    return()
  endif()

  # Detect clang-tidy
  find_program(CLANGTIDY_PROGRAM NAMES "clang-tidy")
  if (CLANGTIDY_PROGRAM-NOTFOUND)
    message(FATAL_ERROR "No clang-tidy available!")
  endif()

  # Add clang-tidy to CMake target
  set_target_properties(${_target_name}
    PROPERTIES
      CXX_CLANG_TIDY "${CLANGTIDY_PROGRAM}")
endfunction()

#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#

