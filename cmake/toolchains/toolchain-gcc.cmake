#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#
#----------------------------------------------------------------------
set(CMAKE_CONFIGURATION_TYPES
  Debug
  Profile
  Release
)
set(CMAKE_CONFIGURATION_TYPES ${CMAKE_CONFIGURATION_TYPES}
  CACHE INTERNAL
  "Solution wide build configuration types override"
  FORCE
)
#----------------------------------------------------------------------
if (NOT CMAKE_C_COMPILER)
  set(CMAKE_C_COMPILER gcc)
endif()

if (NOT CMAKE_CXX_COMPILER)
  set(CMAKE_CXX_COMPILER g++)
endif()
#----------------------------------------------------------------------
set(CMAKE_USER_MAKE_RULES_OVERRIDE
  "${CMAKE_CURRENT_LIST_DIR}/overrides-gcc.cmake"
)
#----------------------------------------------------------------------
#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#
