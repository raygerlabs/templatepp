#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#

#!/usr/bin/env python
# -*- coding: utf-8 -*-
from conans import ConanFile, CMake, tools
import os
import shutil

class IntegrationRecipe(ConanFile):
  settings = "os", "compiler", "build_type", "arch"
  generators = "CMakeDeps"

  def imports(self):
    self.copy("*.dll", src="bin", dst=f"bin/{self.settings.build_type}")
    self.copy("*.dylib*", src="lib", dst="lib")
    self.copy("*.so*", src="lib", dst="lib")

  def build(self):
    cmake = CMake(self)
    cmake.configure()
    cmake.build()

  def test(self):
    if self.settings.os == "Windows":
      os.chdir(f"bin/{self.settings.build_type}")
    else:
      os.chdir("bin")
    self.run(f".{os.sep}integration")

#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#
