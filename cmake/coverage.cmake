#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#

if(COVERAGE)
if(CMAKE_CXX_COMPILER_ID MATCHES "GNU|Clang")
  set(CMAKE_BUILD_TYPE "Debug" FORCE)
  add_compile_options(--coverage -O0 -g3)
  add_link_options(--coverage)
  find_program(LCOV_COMMAND NAMES "lcov")
  if (LCOV_COMMAND)
    add_custom_target(coverage_report
      COMMAND ${LCOV_COMMAND} ARGS
        --capture
        --exclude '*/test/*'
        --exclude '/Library/*'
        --exclude '/usr/include/*'
        --directory .
        --output-file lcov.info
    )
  else()
    message(ERROR "lcov is not found!")
  endif()
else()
  set(COVERAGE OFF FORCE)
endif()
endif()

#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#
