from conans import ConanFile, CMake, tools
import os
import shutil

class templatepp(ConanFile):
  name = "templatepp"
  version = "0.2.0"
  license = "MIT"
  author = "Rajmund Kail"
  url = "https://www.github.com/raygerlabs/templatepp"
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

  def archive_package(self):
    # This function is created for the purpose of automating github release creation;
    # Currently tar.gz and zip format is supported only.
    # - For Windows platform, zip is the preferred archive format;
    # - For other platform tar.gz
    # NOTE: CPack documentation lacks many details and doesn't provide
    # the tools for generating runtime information regarding the package or archive;
    # This is unfortunate, until we find something better, we generate the archive like this
    archive_name = f"{self.name}-v{self.version}-{self.settings.os}-{self.settings.arch}"
    archive_name = archive_name.lower()
    archive_generator = "gztar"
    if self.settings.os == "Windows":
      archive_generator = "zip"
    archive_path = shutil.make_archive(archive_name, archive_generator, self.package_folder)
    with open("package_info.txt", "w") as archive_info:
      print(f"{os.path.basename(archive_path)}", file=archive_info)
    self.output.success(f"Package archive '{os.path.basename(archive_path)}' created")

  def package(self):
    cmake = self.configure_cmake()
    cmake.install()
    self.archive_package()

  def package_info(self):
    self.cpp_info.libs = tools.collect_libs(self)
