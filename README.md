[![build](https://github.com/raygerlabs/templatepp/actions/workflows/build.yml/badge.svg)](https://github.com/raygerlabs/templatepp/actions/workflows/build.yml)
[![License](https://img.shields.io/badge/License-MIT-green.svg)](https://opensource.org/licenses/MIT)
[![Coverage Status](https://coveralls.io/repos/github/raygerlabs/templatepp/badge.svg)](https://coveralls.io/github/raygerlabs/templatepp)

# templatepp

A cross-platform project template for modern C and C++.

## Prerequisites

- Cmake
- Conan
- C/C++ compiler (Visual Studio, gcc, etc)

## Purpose

Our main goal is providing a working C/C++ project template that is easily integratable into real software projects, thus reducing, if not eliminating, most burden of project setup or infrastructural problems from the actual developer. The template considers the most common use cases in modern software development such as coding, testing, QA, documentation and deployment.

We continuously improve and simplify the design to make project integration simple.

It is very important to emphasize we **do not** intend replacing any existing build system or environment, but making the inital project setup faster and convenient.

## Usage

The intended usage of this template is subsequent replacement of names, folders, and modules. Due to the modular design, the components can be easily replaced. The intention is making each separate component to work independently, so if you remove one, it doesn't impact the other component.

## Project Structure

The project has the following submodules:
- templatepp, an example library located under "src" folder
- unit_tests, the unit tests of the example library located under "test" folder
- integration, the integration test of the example library located under "integration" folder

## Workflows

The project supports multiple workflows and depending on your personal taste, you can build the project to your liking. Currently the goal is to let both Cmake and Conan work interchangably and they should not interfere with each other in any way. By adding Conan to the Cmake project without Conan being too intrusive.

### CMake

Before starting working with CMake, you must install the project dependencies first. It is advisable to install in CMAKE_BINARY_DIR for easy integration.

For convenience here is a short cheatsheet:

```
# 1. Install project dependencies from conan remote:
$ conan install . --install-folder /path/to/the/build -s build_type=Release -pr:b default --build missing

# 2.a For a single-configuration generator:
$ cmake -S . -B /path/to/the/build -DCMAKE_BUILD_TYPE=Release
$ cmake --build /path/to/the/build
$ cmake --install /path/to/the/build --prefix /path/to/the/install

# 2.b For a multi-configuration generator:
$ cmake -S . -B /path/to/the/build
$ cmake --build /path/to/the/build --config Release
$ cmake --install /path/to/the/build --config Release --prefix /path/to/wherever

# 3. Run unit tests
$ ctest --test-dir /path/to/the/build -VV -C Release

# 4. Package
$ cmake --build /path/to/the/build --config Release --target package

# or if you prefer, you can call cpack
$ cd /path/to/the/build
$ cpack
```

### Conan

Initially Conan is introduced as a package manager for managing third-parties, but in the end it is realized that it is more than capable of entirely managing whole SW build cycle.

The [conan build stages](https://docs.conan.io/en/latest/reference/commands/development/build.html) can be read here for more details.

For convenience here is a short cheatsheet:

```
# Install dependencies from conan remote:
$ conan install . --install-folder /path/to/the/install -s build_type=Release -pr:b default --build missing

# Build the project
$ conan build . --install-folder /path/to/the/install --build-folder /path/to/the/build
```

#### Install
#### Build

Each build stage can be run separately or they can combined.
```
# Running each build stage:
$ conan build . --configure         <args...>     # only run cmake.configure(). Other methods will do nothing
$ conan build . --build             <args...>     # only run cmake.build(). Other methods will do nothing
$ conan build . --install           <args...>     # only run cmake.install(). Other methods will do nothing
$ conan build . --test              <args...>     # only run cmake.test(). Other methods will do nothing

# Or combining stages:
$ conan build . --configure --build <args...> # run cmake.configure() + cmake.build(), but not cmake.install() nor cmake.test
```

#### Package

The project packaging can be done in multiple stages.

```
# To local build folder
$ conan package . --install-folder /path/to/the/install --build-folder /path/to/the/build

# To local conan cache
$ conan export-pkg . user/channel --install-folder /path/to/the/install --build-folder /path/to/the/build
```

#### Integration

```
# Verify package integrity
$ conan test integration templatepp<version>@user/channel --test-build-folder /path/to/the/test --build missing
```

## Presets

It is recommended **not** to override any compiler setting in the project CMake, but providing presets. A default CMake preset is provided with the project: CMakePresets.json. It provides some suggestions regarding build and compiler settings. The preset will provide the following suggestions.

### Build Types

The following build types are suggested by the Preset settings:

#### Debug

The debug build type works similarly to the default Debug setting provided by CMake. It disables all optimizations and provides full debugging support. It is intended for developers.

#### Profile

The profile build type is similar to RelWithDebInfo. It enables most optimizations but with debugging support. It is intended for fixing bugs or otherwise difficult situations where Debug build type does not suffice.

#### Release

The release build enables all optimizations possible without debugging support. It is intended for creating a new release.

### Compilers

Use every available and reasonable set of warning options. Some warnings only work with optimizations enabled, or work better the higher the optimization setting is, for example `-Wnull-dereference`, thus it is highly advisable to build the project with **Profile** build type when it is possible.

#### GCC/Clang

For clang, do not use `-Weverything` in a production build. Even clang developers dissuade its use. Use it solely for discover whether a particular warning exists in the code.

`-Weffc++` warning mode can be too noisy at times. For now, the preset adds this flag to the build.

##### Warnings

| Flag                       | Description                                                                                       | support (gcc) | support (clang)  |
|----------------------------|---------------------------------------------------------------------------------------------------|---------------|------------------|
| `-pedantic`                | Warn on language extensions                                                                       | X | X | 
| `-Werror`                  | Treat any warning as error                                                                        | X | X |
| `-Wall -Wextra`            | Enable reasonable and standard warnings                                                           | X | X |
| `-Wshadow`                 | Warn the user if a variable declaration shadows one from a parent context                         | X | X |
| `-Wnon-virtual-dtor`       | Warn the user if a class with virtual functions has a non-virtual destructor                      | X | X |
| `-Woverloaded-virtual`     | Warn if you overload (not override) a virtual function                                            | X | X |
| `-Wpedantic`               | Warn if non-standard C++ is used                                                                  | X | X (>=3.2) |
| `-Wmisleading-indentation` | Warn if indentation implies blocks where blocks do not exist                                      | X (>=6.0) | X |
| `-Wnull-dereference`       | Warn if a null dereference is detected                                                            | X | X |
| `-Wcast-align`             | Warn for potential performance problem casts                                                      | X | X |
| `-Wold-style-cast`         | Warn for c-style casts                                                                            | X | X |
| `-Wconversion`             | Warn for implicit conversions that may alter a value                                              | X | X |
| `-Wsign-conversion`        | Warn for implicit conversions that may change the sign of an integer value                        | X (>=4.3) | X |
| `-Wfloat-equal`            | Warn if `==` comparison is used between two `float` instead of comparing with appropriate epsilon | X | X |
| `-Wdouble-promotion`       | Warn if `float` is implicit promoted to `double`                                                  | X(>=4.6) | X(>=3.8) |
| `-Wformat=2`               | Warn on security issues around functions that format output (ie `printf`)                         | X | X |

These flags would be great but clang tools don't support these yet.

| Flag                       | Description                                                                                       | support (gcc) | support (clang)  |
|----------------------------|---------------------------------------------------------------------------------------------------|---------------|------------------|
| `-Wduplicated-cond`        | Warn if `if` / `else` chain has duplicated conditions                                             | X (>=6.0) |  | 
| `-Wduplicated-branches`    | Warn if `if` / `else` branches have duplicated code                                               | X (>=7.0) |  | 
| `-Wlogical-op`             | Warn about logical operations being used where bitwise were probably wanted                       | X |  |
| `-Wuseless-cast`           | Warn if you perform a cast to the same type                                                       | X (>=4.8) |  |

##### Security

The preset aims for
- detect the maximum number of bugs or potential security problems.
- enable security mitigations in the produced binaries.
- enable runtime sanitizers to detect errors (overflows, race conditions, etc.) and make fuzzing more efficient.

Run debug/test builds with sanitizers enabled (see below in the instrumentation section)

| Flag                       | Description                                                                                       |
|----------------------------|---------------------------------------------------------------------------------------------------|
| `-D_FORTIFY_SOURCE=2`      | Enable buffer overrun checks (both compile- and run-time checks)                                  |

##### Performance

| Flag                       | Description                                                                                       |
|----------------------------|---------------------------------------------------------------------------------------------------|
| `-O3`                      | Always build with max optimization level                                                          |

#### Visual Studio

##### Warnings

Please note that `/Wall` flag is not particularly useful, creates too many warnings and also warns on files included from the standard library.

`/permissive- /W4 /w14640` - use these flags and consider the following

| Flag                       | Description                                                                                       |
|----------------------------|---------------------------------------------------------------------------------------------------|
| `/W4`                      | Enable reasonable warning levels                                                                  |
| `/w14242`                  | Warn for implicit conversions that may alter a value                                              |
| `/w14254`                  | Warn for larger bit field assigned to a smaller bit field.                                        |
| `/w14263`                  | Warn if you overload (not override) a virtual function                                            |
| `/w14265`                  | Warn the user if a class with virtual functions has a non-virtual destructor                      |
| `/w14287`                  | Warn the user if `unsigned` variable is used with negative value                                  |
| `/we4289`                  | Warn the user if a loop control variable declared in the for-loop is used outside its scope       |
| `/w14296`                  | Warn the user if `unsigned` variable is used in a comparison operation with zero                  |
| `/w14311`                  | Warn if 64-bit pointer is truncated                                                               |
| `/w14545`                  | Warn if ill-formed comma expression is detected (ie `*(&f), 10;`                                  |
| `/w14546`                  | Warn if ill-formed comma expression is detected (ie `if ( f, k )`)                                |
| `/w14547`                  | Warn if ill-formed comma expression is detected (ie `int l = (i != i,0)`)                         |
| `/w14549`                  | Warn if ill-formed comma expression is detected (ie `if ( i == 0, k )`)                           |
| `/w14555`                  | Warn if an expression has no effect (ie `1;` or `x;`)                                             |
| `/w14619`                  | Warn if non-existent warning is disabled                                                          |
| `/w14640`                  | Warn if static instance of an object is not thread-safe (ie `void f() { static X x; }`)           |
| `/w14826`                  | Warn if conversion between two types are signed extended and may cause undefined behaviour        |
| `/w14905`                  | Warn the user if unsafe cast is detected for LPSTR type (WIN32 API)                               |
| `/w14906`                  | Warn the user if unsafe cast is detected for LPWSTR type (WIN32 API)                              |
| `/w14928`                  | Warn the user if more than one user-defined conversion routine is found                           |

##### Security

| Flag                       | Description                                                                                       |
|----------------------------|---------------------------------------------------------------------------------------------------|
| `/RTC1`                    | Enable run-time type checks                                                                       |
| `/GS`                      | Enable buffer security checks                                                                     |

##### Performance

The below flags are added to the build in order to improve performance.

| Flag                       | Description                                                                                       |
|----------------------------|---------------------------------------------------------------------------------------------------|
| `/Gy`                      | Enable function level linking                                                                     |
| `/GF`                      | Enable string pooling                                                                             |
| `/MP`                      | Build with multiple processors                                                                    |
| `/Ox`                      | Enable aggressive optimization                                                                    |

## Intrumentation

### Static Code Analysis
 
Usage:
```
list(APPEND CMAKE_MODULE_PATH ${PROJECT_SOURCE_DIR}/cmake)
include(static_analysis)
add_clang_format(target)
add_clang_tidy(target)
```

CMake Target: none

```
$ cmake -B /path/to/the/build -DENABLE_LINT=TRUE
```

### Sanity Checks

Usage:
```
list(APPEND CMAKE_MODULE_PATH ${PROJECT_SOURCE_DIR}/cmake)
include(sanity_checks)
sanitize(target)
```

CMake Target: none

```
$ cmake -B /path/to/the/build -DENABLE_SANITIZER=TRUE
```

### Coverage Coverage

**Code coverage is supported only for linux at the moment.**

For generating code coverage you must install the following tools.
```
$ sudo apt install -y lcov genhtml
```

Usage:
```
list(APPEND CMAKE_MODULE_PATH ${PROJECT_SOURCE_DIR}/cmake)
include(code_coverage)
```

CMake Target: coverage

Coverage information can be generated as below. HTML view of coverage is located under /path/to/the/build/coverage
```
$ conan install -if /path/to/the/install -o with_tests=True -o with_coverage=True
$ conan build . -if /path/to/the/install -bf /path/to/the/build
```

## Documentation

### Doxygen

You must have the following tools available on your unix system.

```
$ sudo apt update
$ sudo apt install -y doxygen graphviz texlive-latex-extra
```

Usage:
```
list(APPEND CMAKE_MODULE_PATH ${PROJECT_SOURCE_DIR}/cmake)
include(generate_doc)
```

CMake Target: doc

For generating the documentation, configure CMake such as

```
$ cmake -B /path/to/the/build -DBUILD_DOC=TRUE -DONLY_DOC
$ cmake --build /path/to/the/build --target doc
```

API documentation shall be generated under /path/to/the/build/doc/

The user manual is automatically generated when the release job runs.

## Continuous Integration

This template provides a basic infrastructure for acceptable CI behaviour.

### Build

Every new Pull Request or merge to the master branch, triggers a new build.

The build job will perform the following:
- configures the environment (linux, windows, mac)
- compiles the code
- runs the unit tests
- generates code coverage
- packages the output binaries
- export the package to local conan cache
- runs the integration test
- uploads the artifacts to the articatory

### Release

The release job behaves similarly to the build job except it gets triggered when a new git tag is pushed.

```
$ git tag v1.0.0
$ git push origin v1.0.0
```

In addition to perform a new build, it generates the API documentation and uploads it to the new github release along with the build package.
