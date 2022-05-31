#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#

# Package generators
# Generate tar.gz packages by default
set(CPACK_GENERATOR "TGZ")
set(CPACK_PACKAGE_FILE_EXTENSION ".tar.gz")
if (WIN32)
  # Otherwise for Windows generate zip files
  set(CPACK_GENERATOR "ZIP")
  set(CPACK_PACKAGE_FILE_EXTENSION ".zip")
endif()
set(CPACK_GENERATOR "${CPACK_GENERATOR}" CACHE STRING "CPack package generator type")
set(CPACK_SOURCE_GENERATOR "${CPACK_GENERATOR}" CACHE STRING "CPack source generator type")

# Package information
set(CPACK_PACKAGE_NAME "${PROJECT_NAME}")
set(CPACK_PACKAGE_VERSION ${PROJECT_VERSION})

# Package documentation
set(CPACK_RESOURCE_FILE_README "${PROJECT_SOURCE_DIR}/README.md")
set(CPACK_RESOURCE_FILE_LICENSE "${PROJECT_SOURCE_DIR}/LICENSE")

# Add Cpack support
include(CPack)

# Default package path
if (NOT CPACK_OUTPUT_FILE_PREFIX)
  set(CPACK_OUTPUT_FILE_PREFIX "${PROJECT_BINARY_DIR}")
endif()
if (NOT CPACK_PACKAGE_DIRECTORY)
  set(CPACK_PACKAGE_DIRECTORY "${PROJECT_BINARY_DIR}")
endif()

# Default package name
set (CPACK_PACKAGE_FILE_NAME "${CPACK_PACKAGE_NAME}-${CPACK_PACKAGE_VERSION}-${CPACK_SYSTEM_NAME}")
if (CPACK_PACKAGE_ARCHITECTURE)
  set(CPACK_PACKAGE_FILE_NAME "${CPACK_PACKAGE_FILE_NAME}-${CPACK_PACKAGE_ARCHITECTURE}")
endif()
set(CPACK_PACKAGE_FILE_NAME "${CPACK_PACKAGE_FILE_NAME}" CACHE STRING "CPack package name")
set(CPACK_FULL_PACKAGE_FILE_NAME "${CPACK_PACKAGE_FILE_NAME}${CPACK_PACKAGE_FILE_EXTENSION}")
set(CPACK_FULL_PACKAGE_FILE_NAME "${CPACK_FULL_PACKAGE_FILE_NAME}" CACHE STRING "CPack package name (+extension)")
message(STATUS "CPACK_FULL_PACKAGE_FILE_NAME: ${CPACK_FULL_PACKAGE_FILE_NAME}")
file(WRITE "${PROJECT_BINARY_DIR}/package_info.txt" "${CPACK_FULL_PACKAGE_FILE_NAME}")
#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#