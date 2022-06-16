#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#

# To use with configure_file(...)
string(TOUPPER ${PROJECT_NAME} PACKAGE_PREFIX)

if(BUILD_SHARED_LIBS)
  set(IS_DLL 1)
else()
  set(IS_DLL 0)
endif()

# Write utility files
# Mainly for CI jobs to pickup
file(WRITE ${PROJECT_BINARY_DIR}/NAME ${PROJECT_NAME})
file(WRITE ${PROJECT_BINARY_DIR}/VERSION ${PROJECT_VERSION})

# Generate config header
configure_file(
  ${PROJECT_SOURCE_DIR}/src/config.hpp.in
  ${PROJECT_BINARY_DIR}/include/templatepp/config.hpp
  @ONLY)

# Generate version header
configure_file(
  ${PROJECT_SOURCE_DIR}/src/version.hpp.in
  ${PROJECT_BINARY_DIR}/include/templatepp/version.hpp
  @ONLY)

#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#

