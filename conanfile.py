from conan import ConanFile
from conan.tools.build import cross_building
from conan.tools.cmake import CMake, cmake_layout, CMakeToolchain, CMakeDeps
from conan.tools.files import copy
from os.path import join

class TemplateppRecipe(ConanFile):
  name = "templatepp"
  version = "0.4.0"
  license = "MIT"
  author = "Rajmund Kail raygerlabs@gmail.com"
  url = "https://www.github.com/raygerlabs/templatepp"
  description = "A cross-platform project template for modern C and C++"
  settings = "os", "compiler", "build_type", "arch"
  options = { "shared": [True, False] }
  default_options = { "shared": True }
  generators = "CMakeDeps", "CMakeToolchain"
  exports = ("LICENSE")
  exports_sources = ("cmake/*",
                     "include/*",
                     "templatepp/*",
                     "test/*",
                     "CMakeLists.txt",
                     "README.md",
                     "LICENSE")

  def build_requirements(self):
    self.test_requires("gtest/[^1.11.0]@")

  def configure(self):
    self.options["*"].shared = self.options.shared
    self.options["gtest"].shared = False

  def imports(self):
    self.copy("*.dll", src="bin", dst="bin")
    self.copy("*.dylib*", src="lib", dst="lib")
    self.copy("*.so*", src="lib", dst="lib")

  def layout(self):
    cmake_layout(self)
    self.cpp.source.includedirs = ["include"]
    self.cpp.build.includedirs = ["."] # generated export headers
    self.cpp.build.libs = ["templatepp"]
    self.cpp.package.includedirs = ["include"]
    self.cpp.package.libs = ["templatepp"]
    self.cpp.package.libdirs = ["lib"]
    self.cpp.package.bindirs = ["bin"]

  def configure_cmake(self):
    cmake = CMake(self)
 #   if self.settings.compiler == "Visual Studio":
 #     cmake.configure(args=["--preset=msvc"])
#    elif self.settings.compiler == "clang":
#      cmake.configure(args=["--preset=clang"])
#    elif self.settings.compiler == "apple-clang":
#      cmake.configure(args=["--preset=clang"])
#    elif self.settings.compiler == "gcc":
#      cmake.configure(args=["--preset=gcc"])
#    else:
#      cmake.configure()
    cmake.configure()
    #cmake.verbose = True
    return cmake

  def build(self):
    cmake = self.configure_cmake()
    cmake.build()
    cmake.test()

  def package(self):
    cmake = self.configure_cmake()
    cmake.install()
    self.run("cpack", self.build_folder)
