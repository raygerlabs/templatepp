#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#

# Create a CMake target for code coverage
add_custom_target(coverage)

# Check whether to generate code coverage or not
# - either enabled/disabled by the user
# - or simply isn't supported
if(ENABLE_COVERAGE AND CMAKE_CXX_COMPILER_ID MATCHES "GNU|Clang")
  # Disable optimizations + add instrumentation in the compiler and linker
  add_compile_options(--coverage -O0 -g3)
  add_link_options(--coverage)
  
  # Detect lcov program
  find_program(LCOV_PROGRAM NAMES "lcov")
  if (LCOV_PROGRAM) # Is lcov installed on your system?
    add_custom_target(lcov # Create CMake target for lcov
      COMMAND ${LCOV_PROGRAM}
        --quiet                   # Do not print progress
        --capture                 # Set capture mode
        --exclude "integration/*" # Exclude non-production code
        --exclude "*/test/*"
        --exclude "gtest*"
        --exclude "gmock*"
        --exclude "*/.conan/*"
        --exclude "/usr/include/*"
        --exclude "/Library/*"
        --directory ${PROJECT_SOURCE_DIR}
        --output-file ${PROJECT_BINARY_DIR}/coverage.info
      COMMENT "Generating code coverage" VERBATIM)
    add_dependencies(coverage lcov) # Add lcov to the target
  endif()
  
  # Detect genhtml
  find_program(GENHTML_PROGRAM NAMES "genhtml")
  if (GENHTML_PROGRAM) # Is genhtml installed on your system?
    add_custom_target(genhtml # Create CMake target for genhtml
      COMMAND ${GENHTML_PROGRAM}
        --legend ${PROJECT_BINARY_DIR}/coverage.info
        --output-directory ${PROJECT_BINARY_DIR}/coverage
        --frames
        --show-details
        --demangle-cpp
      DEPENDS lcov
      COMMENT "Generating html version of code coverage" VERBATIM)
    add_dependencies(coverage genhtml) # Add genhtml to the target
  endif()
endif()

#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#
