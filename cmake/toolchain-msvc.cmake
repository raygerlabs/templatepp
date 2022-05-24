set(CMAKE_CONFIGURATION_TYPES
  Debug
  Profile
  Release
  CACHE INTERNAL
  "Default build configuration types override"
  FORCE
)
set(CMAKE_USER_MAKE_RULES_OVERRIDE
  ${CMAKE_CURRENT_LIST_DIR}/overrides-msvc.cmake
)
