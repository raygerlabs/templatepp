from conans import ConanFile, CMake, tools
import os
import shutil

class TemplateppRecipe(ConanFile):
  name = "templatepp"
  version = "0.4.0"
  license = "MIT"
  author = "Rajmund Kail raygerlabs@gmail.com"
  url = "https://www.github.com/raygerlabs/templatepp"
  description = "A cross-platform project template for modern C and C++"
  settings = "os", "compiler", "build_type", "arch"
  options = { "shared": [True, False], "with_tests": [True, False], "with_presets": [True, False], "with_packaging": [True, False] }
  default_options = { "shared": True, "with_tests": False, "with_presets": False, "with_packaging": True }
  generators = "CMakeDeps"
  exports = "LICENSE"
  exports_sources = "cmake/*", "include/*", "integration/*", "src/*", "test/*", "CMakeLists.txt", "CMakePresets.json", "README.md", "LICENSE"

  def build_requirements(self):
    self.test_requires("gtest/[^1.11.0]@")

  def configure(self):
    self.options["*"].shared = self.options.shared
    self.options["gtest"].shared = False

  def imports(self):
    self.copy("*.dll", src="bin", dst="bin")
    self.copy("*.dylib*", src="lib", dst="lib")
    self.copy("*.so*", src="lib", dst="lib")

  def configure_cmake(self):
    cmake = CMake(self)
    cmake.definitions["BUILD_TESTING"] = self.options.with_tests
    cmake.definitions["BUILD_PACKAGING"] = self.options.with_packaging
    if self.options.with_presets:
      if self.settings.compiler == "Visual Studio":
        cmake.configure(args=["--preset=msvc"])
      elif self.settings.compiler == "clang":
        cmake.configure(args=["--preset=clang"])
      elif self.settings.compiler == "apple-clang":
        cmake.configure(args=["--preset=clang"])
      elif self.settings.compiler == "gcc":
        cmake.configure(args=["--preset=gcc"])
      else:
        cmake.configure()
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
    if self.options.with_packaging:
      self.run("cpack", self.build_folder)

  def package_info(self):
    self.cpp_info.libs = tools.collect_libs(self)
