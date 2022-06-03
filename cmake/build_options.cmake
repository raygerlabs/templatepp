#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#
#----------------------------------------------------------------------
set(CMAKE_SUPPRESS_REGENERATION ON)
set(CMAKE_VERBOSE_MAKEFILE ON)
#----------------------------------------------------------------------
set_property(GLOBAL PROPERTY USE_FOLDERS ON)
#----------------------------------------------------------------------
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)
#----------------------------------------------------------------------
set(CMAKE_POSITION_INDEPENDENT_CODE ON)
#----------------------------------------------------------------------
set(CMAKE_CXX_VISIBILITY_PRESET hidden)
set(CMAKE_VISIBILITY_INLINES_HIDDEN ON)
#----------------------------------------------------------------------
if (BUILD_SHARED_LIBS)
  set(PACKAGE_IS_A_DLL 1)
else()
  set(PACKAGE_IS_A_DLL 0)
endif()
#----------------------------------------------------------------------
#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#
