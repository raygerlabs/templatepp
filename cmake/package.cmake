#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#
### Package information
string (TOUPPER "${PROJECT_NAME}" PACKAGE_PREFIX)

#Define cmake install path
if(WIN32 AND NOT CYGWIN)
  set(CONFIG_INSTALL_DIR cmake)
else()
  set(CONFIG_INSTALL_DIR ${CMAKE_INSTALL_LIBDIR}/cmake/${PROJECT_NAME})
endif()
set(CONFIG_INSTALL_DIR ${CONFIG_INSTALL_DIR} CACHE PATH "Installation path for CMake config files")

# Package generators
# Generate tar.gz
if (NOT CPACK_GENERATOR)
  set(CPACK_GENERATOR "TGZ")
  set(ARCHIVE_EXTENSION ".tar.gz")
  if (WIN32)
    # On Windows generate zip
    set(CPACK_GENERATOR "ZIP")
    set(ARCHIVE_EXTENSION ".zip")
  endif()
endif()

# Package information
set(CPACK_PACKAGE_NAME "${PROJECT_NAME}")
set(CPACK_PACKAGE_VERSION ${PROJECT_VERSION})
set(CPACK_ARCHIVE_COMPONENT_INSTALL ON)
set(CPACK_DEB_COMPONENT_INSTALL ON)
# Package documentation
set(CPACK_RESOURCE_FILE_WELCOME "${CMAKE_SOURCE_DIR}/README.md")
set(CPACK_RESOURCE_FILE_README "${CMAKE_SOURCE_DIR}/README.md")
set(CPACK_RESOURCE_FILE_LICENSE "${CMAKE_SOURCE_DIR}/LICENSE")

# Add Cpack support
include(CPack)

# Include/exclude top level directory
set(CPACK_INCLUDE_TOPLEVEL_DIRECTORY TRUE)

# Set packaging path
if (NOT CPACK_OUTPUT_FILE_PREFIX)
  set(CPACK_OUTPUT_FILE_PREFIX "${PROJECT_BINARY_DIR}")
endif()
if (NOT CPACK_PACKAGE_DIRECTORY)
  set(CPACK_PACKAGE_DIRECTORY "${PROJECT_BINARY_DIR}")
endif()

# Set package file name
set (CPACK_PACKAGE_FILE_NAME "${CPACK_PACKAGE_NAME}-${CPACK_PACKAGE_VERSION}-${CPACK_SYSTEM_NAME}")
if (CPACK_PACKAGE_ARCHITECTURE)
  set(CPACK_PACKAGE_FILE_NAME "${CPACK_PACKAGE_FILE_NAME}-${CPACK_PACKAGE_ARCHITECTURE}")
endif()
#set(CPACK_ARCHIVE_FILE_NAME "${CPACK_PACKAGE_FILE_NAME}${ARCHIVE_EXTENSION}")
file(WRITE "${PROJECT_BINARY_DIR}/package_info.txt" "${CPACK_ARCHIVE_FILE_NAME}")

#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#