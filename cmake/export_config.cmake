#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#
#------------------------------------------------------------------------------
# Add export configuration
# .. for the install-tree
file(RELATIVE_PATH
  INSTALL_PREFIX_REL2CONFIG_DIR
  "${CMAKE_INSTALL_PREFIX}/${PACKAGE_INSTALL_CONFIGDIR}"
  "${CMAKE_INSTALL_PREFIX}"
  
)
configure_file(
  "${CMAKE_CURRENT_LIST_DIR}/config/config.cmake.in"
  "${PROJECT_BINARY_DIR}/${PROJECT_NAME}-config-install.cmake"
  @ONLY
)
install (
  FILES "${PROJECT_BINARY_DIR}/${PROJECT_NAME}-config-install.cmake"
  RENAME "${PROJECT_NAME}-config.cmake"
  DESTINATION ${PACKAGE_INSTALL_CONFIGDIR}
)
install (
  EXPORT "${PROJECT_NAME}-targets"
  NAMESPACE ${PROJECT_NAME}::
  DESTINATION ${PACKAGE_INSTALL_CONFIGDIR}
)
#------------------------------------------------------------------------------
# .. for the build-tree
set(INSTALL_PREFIX_REL2CONFIG_DIR .)
configure_file(
  "${CMAKE_CURRENT_LIST_DIR}/config/config.cmake.in"
  "${PROJECT_BINARY_DIR}/${PROJECT_NAME}-config.cmake"
  @ONLY
)
export(PACKAGE ${PROJECT_NAME})
#------------------------------------------------------------------------------
# .. for both
configure_file(
  "${CMAKE_CURRENT_LIST_DIR}/config/version.cmake.in"
  "${PROJECT_BINARY_DIR}/${PROJECT_NAME}-config-version.cmake"
  @ONLY
)
install (
  FILES "${PROJECT_BINARY_DIR}/${PROJECT_NAME}-config-version.cmake"
  DESTINATION ${PACKAGE_INSTALL_CONFIGDIR}
)
#------------------------------------------------------------------------------
#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#