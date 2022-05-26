from conans import ConanFile, CMake, tools
import os
import shutil

class ProjectInitCpp(ConanFile):
  name = "project-init-cpp"
  version = "0.1"
  license = "MIT"
  author = "Rajmund Kail"
  url = "https://www.github.com/raygerlabs/project-init-cpp"
  description = "A cross-platform project template for modern C and C++"
  settings = "os", "compiler", "build_type", "arch"
  requires = "gtest/1.11.0"
  generators = "CMakeDeps"

  def configure_cmake(self):
    cmake = CMake(self)
    if self.settings.compiler == "Visual Studio":
      cmake.configure(args=["--preset=msvc"])
    elif self.settings.compiler == "gcc":
      cmake.configure(args=["--preset=gcc"])
    elif self.settings.compiler == "clang":
      cmake.configure(args=["--preset=clang"])
    elif self.settings.compiler == "apple-clang":
      cmake.configure(args=["--preset=clang"])
    else:
      cmake.configure()
    cmake.verbose = True
    return cmake

  def build(self):
    cmake = self.configure_cmake()
    cmake.build()
    cmake.test()

  def make_artifact(self):
    artifact_name = f"{self.name}-v{self.version}-{self.settings.os}-{self.settings.arch}"
    artifact_name = artifact_name.lower()
    artifact_format = "gztar"
    if self.settings.os == "Windows":
      artifact_format = "zip"
    artifact_path = shutil.make_archive(artifact_name, artifact_format, self.package_folder)
    with open("artifact_name.txt", "w") as fartifact_name:
      print(f"{os.path.basename(artifact_path)}", file=fartifact_name)
    with open("artifact_path.txt", "w") as fartifact_path:
      print(f"{artifact_path}", file=fartifact_path)
    self.output.success(f"Artifact '{os.path.basename(artifact_path)}' created")

  def package(self):
    cmake = self.configure_cmake()
    cmake.install()
    self.make_artifact()

  def package_info(self):
    self.cpp_info.libs = tools.collect_libs(self)
