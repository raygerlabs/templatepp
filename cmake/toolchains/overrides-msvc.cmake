#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#

#------------------------------------------------------------------------------
# Compiler flags
#------------------------------------------------------------------------------

set(CMAKE_CXX_FLAGS_INIT
  /WX                        # Treat any compiler warning as error
  /permissive-               # Enforce standard conformance
  /EHsc                      # Enable C++ exceptions
  /GR                        # Enable RTTI
  /MP                        # Build with multiple processors
  /GF                        # Enable string pooling
  /Gy                        # Enable function level linking
  /utf-8                     # Set utf-8 for sources and binaries
  /W4                        # Baseline reasonable warning level
  /w14242                    # 'identfier': conversion
                             # from 'type1' to 'type1',
                             # possible loss of data
  /w14254                    # 'operator': conversion from
                             # 'type1:field_bits' to
                             # 'type2:field_bits',
                             # possible loss of data
  /w14263                    # 'function': member function
                             # does not override any base class
                             # virtual member function
  /w14265                    # 'classname': class has
                             # virtual functions, but destructor is
                             # not virtual instances of this class
                             # may not be destructed correctly
  /w14287                    # 'operator': unsigned/negative
                             # constant mismatch
  /we4289                    # nonstandard extension used:
                             # 'variable': loop control variable
                             # declared in the for-loop is used
                             # outside the for-loop scope
  /w14296                    # 'operator': expression is always
                             # 'boolean_value'
  /w14311                    # 'variable': pointer truncation from
                             # 'type1' to 'type2'
  /w14545                    # expression before comma evaluates to a
                             # function which is missing
                             # an argument list
  /w14546                    # function call before comma missing
                             # argument list
  /w14547                    # 'operator': operator before comma has
                             # no effect; expected operator
                             # with side-effect
  /w14549                    # 'operator': operator before comma has
                             # no effect; did you intend 'operator'?
  /w14555                    # expression has no effect; expected
                             # expression with side-effect
  /w14619                    # pragma warning: there is
                             # no warning number 'number'
  /w14640                    # Enable warning on thread
                             # un-safe static member initialization
  /w14826                    # Conversion from 'type1' to 'type_2'
                             # is sign-extended. This may cause
                             # unexpected runtime behavior.
  /w14905                    # wide string literal cast to 'LPSTR'
  /w14906                    # string literal cast to 'LPWSTR'
  /w14928                    # illegal copy-initialization;
                             # more than one user-defined conversion
                             # has been implicitly applied
)

set(CMAKE_CXX_FLAGS_DEBUG_INIT
  /Zi /Zo                    # Enable debugging information
  /Od                        # Disable compiler code optimizations
  /RTC1                      # Enable runtime type checks
  /GS                        # Enable buffer security checks
  /D_DEBUG /DDEBUG           # Enable debug assertions
)

set(CMAKE_CXX_FLAGS_PROFILE_INIT
  /Zi /Zo                    # Enable debugging information
  /Ox                        # Enable compiler code optimizations
  /Oy-                       # Do not omit frame pointers
  /GS-                       # Disable buffer security checks
  /D_PROFILE /DNDEBUG        # Disable debug assertions
)

set(CMAKE_CXX_FLAGS_RELEASE_INIT
  /Ox                        # Enable compiler code optimizations
  /GS-                       # Disable buffer security checks
  /D_RELEASE /DNDEBUG        # Disable debug assertions
)

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
# Linker flags
#------------------------------------------------------------------------------

# Enable debugging for Debug and Profile
foreach(_BINTYPE IN ITEMS
  EXE
  SHARED
  MODULE
)
foreach(_BUILDTYPE IN ITEMS
  DEBUG
  PROFILE
)
set(CMAKE_${_BINTYPE}_LINKER_FLAGS_${_BUILDTYPE}_INIT
  ${CMAKE_${_BINTYPE}_LINKER_FLAGS_${_BUILDTYPE}_INIT}
  /debug                     # Generate debugging information
)
string(
  REPLACE ";" " "
    CMAKE_${_BINTYPE}_LINKER_FLAGS_${_BUILDTYPE}_INIT
    "${CMAKE_${_BINTYPE}_LINKER_FLAGS_${_BUILDTYPE}_INIT}"
)
endforeach()
endforeach()

# Enable optimizations for Profile and Release
foreach(_BINTYPE IN ITEMS
  EXE
  SHARED
  MODULE
)
foreach(_BUILDTYPE IN ITEMS
  PROFILE
  RELEASE
)
set(CMAKE_${_BINTYPE}_LINKER_FLAGS_${_BUILDTYPE}_INIT
  ${CMAKE_${_BINTYPE}_LINKER_FLAGS_${_BUILDTYPE}_INIT}
  /opt:ref                   # Eliminate unused data or functions
  /opt:icf                   # Enable COMDAT folding
  /incremental:no            # Disable incremental linkage
)
string(
  REPLACE ";" " "
    CMAKE_${_BINTYPE}_LINKER_FLAGS_${_BUILDTYPE}_INIT
    "${CMAKE_${_BINTYPE}_LINKER_FLAGS_${_BUILDTYPE}_INIT}"
)
endforeach()
endforeach()

#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#
