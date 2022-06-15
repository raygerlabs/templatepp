#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#

#!/usr/bin/env python
# -*- coding: utf-8 -*-

from conans import ConanFile, CMake, tools
import os
import shutil

class TemplateppRecipe(ConanFile):
  name = "templatepp"
  version = "1.0.0"
  description = "A cross-platform project template for modern C and C++."
  url = "https://www.github.com/raygerlabs/templatepp.git"
  license = "MIT"
  author = "Rajmund Kail (raygerlabs@gmail.com)"
  topics = ("conan", "cmake", "project-template", "build")
  settings = "os", "compiler", "build_type", "arch"
  options = {
    "shared": [True, False],
    "fPIC": [True, False],
    "with_cpack": [True, False],
    "with_presets": [True, False],
    "with_tests": [True, False]
  }
  default_options = {
    "shared": True,
    "fPIC": True,
    "with_cpack": False,
    "with_presets": False,
    "with_tests": False
  }
  exports = [
    "README.md",
    "LICENSE"
  ]
  exports_sources = [
    "include/*",
    "src/*",
    "cmake/*",
    "CMakeLists.txt"
  ]
  generators = "CMakeDeps"

  def configure(self):
    if self.settings.compiler == 'Visual Studio':
      del self.options.fPIC

  def build_requirements(self):
    if self.options.with_tests:
      self.test_requires("gtest/[^1.11.0]@")

  def requirements(self):
    self.requires("sdl/2.0.20")

  def config_options(self):
    if self.options.with_tests:
      self.options["gtest"].shared = False # CTest is broken with shared GTest lib
    self.options["sdl2"].shared = self.options.shared
    self.options["sdl2"].sdl2main = False # We have our own main() function

  def imports(self):
    self.copy("*.dll", src="bin", dst=f"bin/{self.settings.build_type}")
    self.copy("*.dylib*", src="lib", dst="lib")
    self.copy("*.so*", src="lib", dst="lib")

  def configure_cmake(self):
    cmake = CMake(self)
    cmake.definitions["BUILD_TESTS"] = self.options.with_tests
    if self.options.with_presets:
      cmake.configure(args=[f"--preset={self.settings.compiler}"])
    else:
      cmake.configure()
    cmake.verbose = True
    return cmake

  def build(self):
    cmake = self.configure_cmake()
    cmake.build()
    if self.options.with_tests:
      cmake.test()

  def package(self):
    cmake = self.configure_cmake()
    cmake.install()
    if self.options.with_cpack:
      cmake.build(target="package")

  def package_info(self):
    self.cpp_info.libs = self.collect_libs()

#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#
