[![build](https://github.com/raygerlabs/project-init-cpp/actions/workflows/build.yml/badge.svg)](https://github.com/raygerlabs/project-init-cpp/actions/workflows/build.yml)

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

Conan is introduced as a package manager for managing third-parties but it is capable of managing whole SW build cycle so effectively replaced Cmake.

#### Conan Workflow

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
$ conan build .. -c -b # run cmake.configure() + cmake.build(), but not cmake.install() nor cmake.test

# 3. Package project
$ conan package ..
```
