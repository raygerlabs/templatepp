#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#

# Show diagnostic messages
set(CMAKE_VERBOSE_MAKEFILE ON)
# Generate compile commands in separate file
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

# Enable IDE folders
# Create folders to organize sub-projects
# - add "CMakePredefinedTargets" folder by default
# - add CMake defined projects, for example INSTALL or ZERO_CHECK
set_property(GLOBAL PROPERTY USE_FOLDERS ON) 

# C++ standard enforcement
# Build with no less than C++17 standard
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

# Enable position independent code
set(CMAKE_POSITION_INDEPENDENT_CODE ON)

# Default ELF symbol visibility
set(CMAKE_CXX_VISIBILITY_PRESET hidden)
set(CMAKE_VISIBILITY_INLINES_HIDDEN ON)

#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#
