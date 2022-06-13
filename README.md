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

### Project Structure

The project has the following submodules:
- templatepp, the main library this project provides (src/include)
- unit_tests, the unit tests of the main library (test)
- integration, the integration test of the main library (integration)

#### CMake Presets

You can build the project with or without CMake presets. It is configurable via conan settings.
Each preset provides debug and optimized build configs (profile and release).

The following compiler presets are supported at the moment:
- gcc
- clang
- msvc

### Build

#### Cmake Workflow

Before starting with Cmake, you must install the project dependencies first. It is advisable to install in CMAKE_BINARY_DIR for easy integration.

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

#### Conan Workflow

Initially, Conan is introduced as a package manager for managing third-parties, but it is entirely capable of managing whole SW build cycle.
The [conan build stages](https://docs.conan.io/en/latest/reference/commands/development/build.html) can be read here for more details.

For convenience here is a short cheatsheet:

```
# Install dependencies from conan remote:
$ conan install . --install-folder tmp/install -s build_type=Release -pr:b default --build missing

# Build the project
$ conan build . --source-folder tmp/source --install-folder tmp/install --build-folder tmp/build

# Each build stage can be run separately:
$ conan build . --configure         <args...>     # only run cmake.configure(). Other methods will do nothing
$ conan build . --build             <args...>     # only run cmake.build(). Other methods will do nothing
$ conan build . --install           <args...>     # only run cmake.install(). Other methods will do nothing
$ conan build . --test              <args...>     # only run cmake.test(). Other methods will do nothing
# They can be combined
$ conan build . --configure --build <args...> # run cmake.configure() + cmake.build(), but not cmake.install() nor cmake.test

```

### Packaging

The project packaging can be done in multiple stages.

```
# To local build folder
$ conan package . --source-folder tmp/source --install-folder tmp/install --build-folder tmp/build

# To local conan cache
$ conan export-pkg . user/channel --source-folder tmp/source --install-folder tmp/install --build-folder tmp/build
```

### Integration

```
# Verify package integrity
$ conan test integration templatepp<version>@user/channel --test-build-folder tmp/test --build missing
```

### Documentation

#### Doxygen

You must have the following tools available on your unix system.

```
$ sudo apt update
$ sudo apt install -y doxygen graphviz texlive-latex-extra
```

For generating the documentation, configure CMake such as

```
$ cmake -Bbuild -DBUILD_DOC=TRUE
$ cmake --build build --target doxydoc pdfdoc
```

API documentation shall be generated under /path/to/the/build/<doc>

The user manual is automatically generated when the release job runs.

#### hdoc

The user guide can be found here:
- [Getting Started](https://hdoc.io/docs/intro/getting-started/)
- [Troubleshooting](https://hdoc.io/docs/intro/troubleshooting/)
- [API Doc](https://hdoc.io/docs/features/api-docs/)
- [Pages](https://hdoc.io/docs/features/markdown-pages/)
- [Configuration](https://hdoc.io/docs/reference/config-file-reference/)
- [Exclusion](https://hdoc.io/docs/features/excluding-code/)

The generated API documentation can be found here:
- [https://docs.hdoc.io/raygerlabs/templatepp/](https://docs.hdoc.io/raygerlabs/templatepp/)

As of now, **hdoc** is not automated.

### Continuous Integration

This template provides a basic infrastructure for acceptable CI behaviour.

#### Build

Every new Pull Request or merge to the master branch, triggers a new build. The build workflow can be found at .github/workflows/build.yml.

The build job will perform the following:
- configures the environment (linux, windows, mac)
- compiles the code
- runs the unit tests
- packages the output binaries
- export the package to local conan cache
- runs the integration test
- uploads the artifacts to the articatory

#### Release

If a new git tag is pushed, it will trigger the release job. The release job can be found at .github/workflows/release.yml.
```
$ git tag v1.0.0
$ git push origin v1.0.0
```

The release job will perform the following:
- Executes the same step as per the build
- Creates a new github release
- Generates API documentation (user manual)
- Uploads the user manual to the github release
- Uploads the artifacts to the github release
