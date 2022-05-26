# project-init-cpp

A cross-platform project template for modern C and C++.

### Prerequisites

This project assumes the following tools are available on the build machine.
- Cmake
- Conan
- C/C++ compiler (Visual Studio, Unix Makefiles, etc)

### Purpose

The main purpose of this project template is to provide an empty husk for a new C++ project. By reducing the cost of infrastructural or otherwise tedious tasks, this template shall provide the most common use cases in SW development such as coding standards, testing, Q&A, documentation and deployment. 

It is very important to emphasize this template is not intended for replacing any existing build system or environment. Rather the goal is to make initial project setup faster and convenient.

The project layout is insired by this [article](https://www.open-std.org/jtc1/sc22/wg21/docs/papers/2018/p1204r0.html).

### Usage

The intended usage is subsequent string replacement of project names and settings on a working copy.

### Build

Conan is introduced as a package manager for managing third-parties but Cmake build is the primary focus.

```
# 1. Install project dependencies:
$ conan install . -if build -s build_type=Release -pr:b default --build missing

# 2.a For a single-configuration generator:
$ cmake -S . -B build -DCMAKE_BUILD_TYPE=Release
$ cmake --build build
$ cmake --install build --prefix /path/to/wherever

# 2.b For a multi-configuration generator:
$ cmake -S . -B build
$ cmake --build build --config Release
$ cmake --install build --config Release --prefix /path/to/wherever

# 3. Execute unit tests
$ ctest --test-dir build -VV -C Release

# 4. Create package
$ cmake --build build --config Release --target package
```
