#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#

function(sanitize _target_name)
  # Check correct usage of this function
  if (NOT TARGET ${_target_name})
    message(FATAL_ERROR "function 'add_clang_format' called on non-target"
                        "(got ${_target_name})")
  endif ()
  
  # Check whether to enable sanitizers
  if(NOT ENABLE_SANITIZER)
    return()
  endif()
  
  # Enable sanitizers
  if (CMAKE_CXX_COMPILER_ID MATCHES "GNU|Clang")
    # Unfortunately not all sanitizers can be enabled at a time,
    # because they aren't compatible with each other.
    # For example, -fsanitize=leak and -fsanitize=thread combo is not
    # TODO: Think about how to provide a better control on sanitizers!
    target_compile_options(${_target_name} PUBLIC
      -fsanitize=address
      -fsanitize=leak
      -fsanitize=undefined
    )
    target_link_options(${_target_name} PUBLIC
      -fsanitize=address
      -fsanitize=leak
      -fsanitize=undefined
    )
  endif()
endfunction()


#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#
