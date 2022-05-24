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

  def archive(self):
    archive_name = f"{self.name}-v{self.version}-{self.settings.os}-{self.settings.arch}"
    archive_name = archive_name.lower()
    archive_format = "gztar"
    if self.settings.os == "Windows":
      archive_format = "zip"
    archive_path = shutil.make_archive(archive_name, archive_format, self.package_folder)
    with open("archive_path.txt", "w") as archive_path_file:
      print(f"{archive_path}", file=archive_path_file)
    with open("archive_name.txt", "w") as archive_name_file:
      print(f"{os.path.basename(archive_path)}", file=archive_name_file)
    return archive_path

  def package(self):
    cmake = self.configure_cmake()
    cmake.install()
    self.archive()

  def package_info(self):
    self.cpp_info.libs = tools.collect_libs(self)
