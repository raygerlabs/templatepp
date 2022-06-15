if(CLANG_DEVTOOLS)
if(CMAKE_CXX_COMPILER_ID MATCHES "GNU|Clang")
  file(GLOB_RECURSE ALL_CPP_SOURCE_FILES
      ${PROJECT_SOURCE_DIR}/src/*.[ch]pp
      ${PROJECT_SOURCE_DIR}/include/*.hpp
  )
  find_program(CLANG_FORMAT "clang-format")
  if(CLANG_FORMAT)
      add_custom_target(
          TARGET format
          COMMAND clang-format
          -i
          -style=file
          ${ALL_CPP_SOURCE_FILES}
      )
  endif()
  find_program(CLANG_TIDY "clang-tidy")
  if(CLANG_TIDY)
      add_custom_target(
          TARGET tidy
          COMMAND clang-tidy
          ${ALL_CPP_SOURCE_FILES}
          -format-style=file
          --
          -I{PROJECT_ROOT_DIR}/include
      )
  endif()
else()
  set(CLANG_DEVTOOLS OFF FORCE)
endif()
endif()
