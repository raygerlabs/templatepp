from conan import ConanFile
from conan.tools.build import cross_building
from conan.tools.cmake import CMake
from os.path import join

class TemplateppIntegrationTest(ConanFile):
    settings = "os", "compiler", "build_type", "arch"
    generators = "CMakeDeps"

    def build(self):
        cmake = CMake(self)
        cmake.configure()
        cmake.build()

    def test(self):
        if not cross_building(self):
            executable = join(self.cpp.build.bindirs[0], "templatepp_app")
            self.run(executable, run_environment=True)
