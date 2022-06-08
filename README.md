[![build](https://github.com/raygerlabs/templatepp/actions/workflows/build.yml/badge.svg)](https://github.com/raygerlabs/templatepp/actions/workflows/build.yml)
[![License](https://img.shields.io/badge/License-MIT-green.svg)](https://opensource.org/licenses/MIT)

# templatepp

A cross-platform project template for modern C and C++.

### Prerequisites

- Cmake
- Conan
- C/C++ compiler (Visual Studio, gcc, etc)

### Purpose

Our main goal is providing a working C/C++ project template that is easily integratable into real software projects, thus reducing, if not eliminating, most burden of project setup or infrastructural problems from the actual developer. The template considers the most common use cases in modern software development such as coding, testing, QA, documentation and deployment.

We continuously improve and simplify the design to make project integration simple.

It is very important to emphasize we **do not** intend replacing any existing build system or environment, but making the inital project setup faster and convenient.

### Usage

The intended usage of this template is subsequent replacement of names, folders, and modules. Due to the modular design the project components can be easily replaced.

### Build

#### Cmake Workflow

Before starting with Cmake, you must install the project dependencies first. It is advisable to install in CMAKE_BINARY_DIR for easy integration.

For convenience here is a short cheatsheet:

```
# 1. Install project dependencies:
$ conan install . -if /path/to/the/build -s build_type=Release -pr:b default --build missing

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

#### Conan Workflow

Initially, Conan is introduced as a package manager for managing third-parties, but it is entirely capable of managing whole SW build cycle.
The [conan build stages](https://docs.conan.io/en/latest/reference/commands/development/build.html) can be read here for more details.

For convenience here is a short cheatsheet:

```
# Copy the sources
$ conan source . -sf tmp/source

# Install dependencies:
$ conan install . -if tmp/install -s build_type=Release -pr:b default --build missing

# Build
$ conan build . -sf tmp/source -if tmp/install -bf tmp/build

# You can run each build stage separately:
$ conan build . -sf tmp/source -if tmp/install -bf tmp/build --configure # only run cmake.configure(). Other methods will do nothing
$ conan build . -sf tmp/source -if tmp/install -bf tmp/build --build     # only run cmake.build(). Other methods will do nothing
$ conan build . -sf tmp/source -if tmp/install -bf tmp/build --install   # only run cmake.install(). Other methods will do nothing
$ conan build . -sf tmp/source -if tmp/install -bf tmp/build --test      # only run cmake.test(). Other methods will do nothing
# They can be combined
$ conan build . -sf tmp/source -if tmp/install -bf tmp/build --configure --build # run cmake.configure() + cmake.build(), but not cmake.install() nor cmake.test

# 3. Package
$ conan package . -sf tmp/source -if tmp/install -bf tmp/build

# 4. Export conan package
$ conan export-pkg .. user/channel -sf tmp/source -if tmp/install -bf tmp/build -pr:b default

# 5. Run integration test
$ cd interation
$ conan test . templatepp<version>@user/channel -tbf tmp/test -s build_type=Release -pr:b default --build missing
```
