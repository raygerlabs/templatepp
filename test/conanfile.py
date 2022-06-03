from conan import ConanFile
from conan.tools.build import cross_building
from conan.tools.cmake import CMake, cmake_layout
from os.path import join

class TemplateppIntegrationTestRecipe(ConanFile):
  settings = "os", "compiler", "build_type", "arch"
  generators = "CMakeToolchain", "CMakeDeps"

  def imports(self):
    self.copy("*.dll", src="bin", dst="bin")
    self.copy("*.dylib*", src="lib", dst="lib")
    self.copy("*.so*", src="lib", dst="lib")

  def build(self):
    cmake = CMake(self)
    cmake.configure()
    cmake.build()

  def test(self):
    if not cross_building(self):
      path = join(self.build_folder, "bin")
      self.run(f"{path}/integration_test", run_environment=True)
