#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#
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
#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#
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
#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#
set(MSVC_LINKER_FLAGS_DEBUG
  /DEBUG                     # Generate debug information
)
set(MSVC_LINKER_FLAGS_RELEASE
  /INCREMENTAL:NO            # Disable incremental linking
                             # Enable optimizations:
  /OPT:REF                   # Eliminate unused functions or data
  /OPT:ICF                   # Perform identical COMDAT folding 
)
string(
  REPLACE ";" " "
    MSVC_LINKER_FLAGS_DEBUG
    "${MSVC_LINKER_FLAGS_DEBUG}"
)
string(
  REPLACE ";" " "
    MSVC_LINKER_FLAGS_RELEASE
    "${MSVC_LINKER_FLAGS_RELEASE}"
)
set(CMAKE_SHARED_LINKER_FLAGS_PROFILE_INIT "/debug /incremental:no /opt:ref /opt:icf")
set(CMAKE_EXE_LINKER_FLAGS_PROFILE_INIT    "/debug /incremental:no /opt:ref /opt:icf")
set(CMAKE_MODULE_LINKER_FLAGS_PROFILE_INIT "/debug /incremental:no /opt:ref /opt:icf")
set(CMAKE_SHARED_LINKER_FLAGS_RELEASE_INIT "/incremental:no /opt:ref /opt:icf")
set(CMAKE_EXE_LINKER_FLAGS_RELEASE_INIT    "/incremental:no /opt:ref /opt:icf")
set(CMAKE_MODULE_LINKER_FLAGS_RELEASE_INIT "/incremental:no /opt:ref /opt:icf")

#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#
