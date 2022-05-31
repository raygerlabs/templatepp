#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#

# Package generators
# Generate tar.gz packages by default
set(CPACK_GENERATOR "TGZ")
set(CPACK_SOURCE_GENERATOR "TGZ")
set(CPACK_PACKAGE_FILE_EXTENSION ".tar.gz")
if (WIN32)
  # Otherwise for Windows generate zip files
  set(CPACK_GENERATOR "ZIP")
  set(CPACK_SOURCE_GENERATOR "ZIP")
  set(CPACK_PACKAGE_FILE_EXTENSION ".zip")
endif()

# Package information
set(CPACK_PACKAGE_NAME "${PROJECT_NAME}")
set(CPACK_PACKAGE_DESCRIPTION_SUMMARY "${PROJECT_DESCRIPTION}")
set(CPACK_PACKAGE_VERSION ${PROJECT_VERSION})
set(CPACK_PACKAGE_VERSION_MAJOR ${PROJECT_VERSION_MAJOR})
set(CPACK_PACKAGE_VERSION_MINOR ${PROJECT_VERSION_MINOR})
set(CPACK_PACKAGE_VERSION_PATCH ${PROJECT_VERSION_PATCH})

# Package documentation
set(CPACK_RESOURCE_FILE_README "${PROJECT_SOURCE_DIR}/README.md")
set(CPACK_RESOURCE_FILE_LICENSE "${PROJECT_SOURCE_DIR}/LICENSE")

# Default package settings
set (CPACK_PACKAGE_FILE_NAME "${CPACK_PACKAGE_NAME}-${CPACK_PACKAGE_VERSION}-${CPACK_SYSTEM_NAME}")
if (CPACK_PACKAGE_ARCHITECTURE)
  set(CPACK_PACKAGE_FILE_NAME "${CPACK_PACKAGE_FILE_NAME}-${CPACK_PACKAGE_ARCHITECTURE}")
endif()
string(TOLOWER "${CPACK_PACKAGE_FILE_NAME}" CPACK_PACKAGE_FILE_NAME)
set(CPACK_PACKAGE_FILE_NAME "${CPACK_PACKAGE_FILE_NAME}" CACHE STRING "CPack package file name")

# Generate package information
set(CPACK_FULL_PACKAGE_FILE_NAME "${CPACK_PACKAGE_FILE_NAME}${CPACK_PACKAGE_FILE_EXTENSION}")
string(TOLOWER "${CPACK_FULL_PACKAGE_FILE_NAME}" CPACK_FULL_PACKAGE_FILE_NAME)
file(WRITE "${PROJECT_BINARY_DIR}/package_info.txt" "${CPACK_FULL_PACKAGE_FILE_NAME}")

# Add Cpack support
include(CPack)

#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#