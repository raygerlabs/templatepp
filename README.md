[![build](https://github.com/raygerlabs/project-init-cpp/actions/workflows/build.yml/badge.svg)](https://github.com/raygerlabs/project-init-cpp/actions/workflows/build.yml)

# project-init-cpp

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

# 3. Execute unit tests
$ ctest --test-dir /path/to/the/build -VV -C Release

# 4. Create package
$ cmake --build /path/to/the/build --config Release --target package

# or if you prever, you can call cpack
$ cd /path/to/the/build
$ cpack
```

#### Conan Workflow

Initially, Conan is introduced as a package manager for managing third-parties, but it is entirely capable of managing whole SW build cycle.
The [conan build stages](https://docs.conan.io/en/latest/reference/commands/development/build.html) can be read here for more details.

For convenience here is a short cheatsheet:

```
# Create build directory:
$ mkdir build
$ cd build

# Install project dependencies:
$ conan install .. -s build_type=Release -pr:b default --build missing

# Build project
$ conan build .. --configure # only run cmake.configure(). Other methods will do nothing
$ conan build .. --build     # only run cmake.build(). Other methods will do nothing
$ conan build .. --install   # only run cmake.install(). Other methods will do nothing
$ conan build .. --test      # only run cmake.test(). Other methods will do nothing
# They can be combined
$ conan build .. --configure --build # run cmake.configure() + cmake.build(), but not cmake.install() nor cmake.test

# 3. Package project
$ conan package ..
```
