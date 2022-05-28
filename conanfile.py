from conans import ConanFile, CMake, tools
import os
import shutil

class ProjectInitCpp(ConanFile):
  name = "project-init-cpp"
  license = "MIT"
  author = "Rajmund Kail"
  url = "https://www.github.com/raygerlabs/project-init-cpp"
  description = "A cross-platform project template for modern C and C++"
  settings = "os", "compiler", "build_type", "arch"
  options = { "shared": [True, False] }
  default_options = { "shared": True }
  generators = "CMakeDeps"

  def requirements(self):
    self.requires("gtest/1.11.0")

  def configure(self):
    self.options["*"].shared = self.options.shared
    self.options["gtest"].shared = False

  def imports(self):
    self.copy("*.dll", src="bin", dst=f"bin/{self.settings.build_type}")
    self.copy("*.dylib*", src="lib", dst="lib")
    self.copy("*.so*", src="lib", dst="lib")

  def configure_cmake(self):
    cmake = CMake(self)
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
    cmake.verbose = True
    return cmake

  def build(self):
    cmake = self.configure_cmake()
    cmake.build()
    cmake.test()

  def package(self):
    cmake = self.configure_cmake()
    cmake.install()
    self.run("cpack", self.build_folder)

  def package_info(self):
    self.cpp_info.libs = tools.collect_libs(self)
