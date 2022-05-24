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

  def package(self):
    cmake = self.configure_cmake()
    cmake.install()
    archive = "{}-{}-{}".format(self.name, self.settings.os, self.settings.arch)
    archive = archive.lower()
    fmt = "gztar"
    if self.settings.os == "Windows":
      fmt = "zip"
    archive = shutil.make_archive(archive, fmt, self.package_folder)
    dest = os.path.join(self.package_folder, "archive")
    os.makedirs(dest, exist_ok=True)
    final = shutil.move(archive, os.path.join(dest, os.path.basename(archive)))
    print("archive_path={}".format(final))

  def package_info(self):
    self.cpp_info.libs = tools.collect_libs(self)
