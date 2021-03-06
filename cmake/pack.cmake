#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#

# Initialize CPack

set(CPACK_GENERATOR "TGZ") # Use tar.gz by default
set(CPACK_SOURCE_GENERATOR "TGZ")
set(CPACK_PACKAGE_FILE_EXTENSION ".tar.gz")
if (WIN32) # But zip for windows
  set(CPACK_GENERATOR "ZIP")
  set(CPACK_SOURCE_GENERATOR "ZIP")
  set(CPACK_PACKAGE_FILE_EXTENSION ".zip")
endif()

# Specify package name/version information
set(CPACK_PACKAGE_NAME "${PROJECT_NAME}")
set(CPACK_PACKAGE_DESCRIPTION_SUMMARY "${PROJECT_DESCRIPTION}")
set(CPACK_PACKAGE_VERSION_MAJOR ${PROJECT_VERSION_MAJOR})
set(CPACK_PACKAGE_VERSION_MINOR ${PROJECT_VERSION_MINOR})
set(CPACK_PACKAGE_VERSION_PATCH ${PROJECT_VERSION_PATCH})
set(CPACK_PACKAGE_VERSION ${PROJECT_VERSION})

# Add resources like README and LICENSE
set(CPACK_RESOURCE_FILE_WELCOME "${CMAKE_SOURCE_DIR}/README.md")
set(CPACK_RESOURCE_FILE_README "${CMAKE_SOURCE_DIR}/README.md")
set(CPACK_RESOURCE_FILE_LICENSE "${CMAKE_SOURCE_DIR}/LICENSE")

# Enable Cpack support
include(CPack)

# Override CPack defaults
set(CPACK_PACKAGE_FILE_NAME "")
string(APPEND CPACK_PACKAGE_FILE_NAME "${CPACK_PACKAGE_NAME}")
string(APPEND CPACK_PACKAGE_FILE_NAME "-${CPACK_PACKAGE_VERSION}")
string(APPEND CPACK_PACKAGE_FILE_NAME "-${CPACK_SYSTEM_NAME}")
if (CPACK_PACKAGE_ARCHITECTURE)
string(APPEND CPACK_PACKAGE_FILE_NAME "-${CPACK_PACKAGE_ARCHITECTURE}")
endif()
string(TOLOWER "${CPACK_PACKAGE_FILE_NAME}" CPACK_PACKAGE_FILE_NAME)
set(CPACK_PACKAGE_FILE_NAME "${CPACK_PACKAGE_FILE_NAME}"
  CACHE STRING "The name of the CPack generated package file")

#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#
