#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#
#------------------------------------------------------------------------------
string(TOUPPER ${PROJECT_NAME} PACKAGE_PREFIX)
#------------------------------------------------------------------------------
if(NOT APPLE)
    set(CMAKE_INSTALL_RPATH $ORIGIN)
endif()
set(CMAKE_SKIP_BUILD_RPATH TRUE)
set(CMAKE_BUILD_WITH_INSTALL_RPATH TRUE)
set(CMAKE_INSTALL_RPATH_USE_LINK_PATH FALSE)
#------------------------------------------------------------------------------
set(PACKAGE_INSTALL_BINDIR bin)
set(PACKAGE_INSTALL_LIBDIR lib)
set(PACKAGE_INSTALL_INCLUDEDIR include)
set(PACKAGE_INSTALL_CONFIGDIR cmake)
set(PACKAGE_INSTALL_DOCDIR doc)
#------------------------------------------------------------------------------
#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#
