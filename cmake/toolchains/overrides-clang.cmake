#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#
#------------------------------------------------------------------------------
set(CMAKE_CXX_FLAGS_INIT
  -pedantic                  # Warn on language extensions
  -Werror                    # Treat compiler warnings as error
  -Wfatal-errors             # Abort compilation on the first error
  -Wall                      # Enable most compiler warnings
  -Wextra                    # Enable reasonable and standard
                             # compiler warnings
  -Wshadow                   # Warn the user if a variable
                             # declaration shadows one from
                             # a parent context
  -Wnon-virtual-dtor         # Warn the user if a class with
                             # virtual functions has a
                             # non-virtual destructor
  -Wold-style-cast           # Warn for c-style casts
  -Wcast-align               # Warn for potential
                             # performance problem casts
  -Wunused                   # Warn on anything being unused
  -Woverloaded-virtual       # Warn if you overload (not override)
                             # a virtual function
  -Wpedantic                 # Warn if non-standard C++ is used
  -Wconversion               # Warn on type conversions that
                             # may lose data
  -Wsign-conversion          # Warn on sign conversions
  -Wmisleading-indentation   # Warn if indentation implies blocks
                             # where blocks do not exist
  -Wnull-dereference         # Warn if a null dereference is detected
  -Wdouble-promotion         # Warn if float is implicit
                             # promoted to double
  -Wformat=2                 # Warn on security issues around functions
                             # that format output (ie printf)
  -msse2                     # Enable use of instructions in the
                             # SSE2 extended instruction sets
)
#------------------------------------------------------------------------------
set(CMAKE_CXX_FLAGS_DEBUG_INIT
  -D_FORTIFY_SOURCE=2        # Detect runtime overflow
  -g                         # Enable native debugging information
  -O0                        # Disable compiler code optimizations
  -D_DEBUG -DDEBUG           # Enable debug assertions
)
#------------------------------------------------------------------------------
set(CMAKE_CXX_FLAGS_PROFILE_INIT
  -O3                        # Enable full compiler code optimizations
  -D_PROFILE -DNDEBUG        # Disable debug assertions
)
#------------------------------------------------------------------------------
set(CMAKE_CXX_FLAGS_RELEASE_INIT
  -O3                        # Enable full compiler code optimizations
  -D_RELEASE -DNDEBUG        # Disable debug assertions
)
#------------------------------------------------------------------------------
string(
  REPLACE ";" " "
    CMAKE_CXX_FLAGS_INIT
    "${CMAKE_CXX_FLAGS_INIT}"
)
string(
  REPLACE ";" " "
    CMAKE_CXX_FLAGS_DEBUG_INIT
    "${CMAKE_CXX_FLAGS_DEBUG_INIT}"
)
string(
  REPLACE ";" " "
    CMAKE_CXX_FLAGS_PROFILE_INIT
    "${CMAKE_CXX_FLAGS_PROFILE_INIT}"
)
string(
  REPLACE ";" " "
    CMAKE_CXX_FLAGS_RELEASE_INIT
    "${CMAKE_CXX_FLAGS_RELEASE_INIT}"
)
#------------------------------------------------------------------------------
set(CMAKE_LINK_FLAGS_INIT "-Wl, --gc-sections")
#------------------------------------------------------------------------------
#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#
