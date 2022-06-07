#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#
#----------------------------------------------------------------------
#!/usr/bin/env python
# -*- coding: utf-8 -*-
from conans import ConanFile, CMake, tools
import os
import shutil
#----------------------------------------------------------------------
class TemplateppIntegrationRecipe(ConanFile):
  settings = "os", "compiler", "build_type", "arch"
  generators = "CMakeDeps"
#----------------------------------------------------------------------
  def imports(self):
    self.copy("*", src="@bindirs", dst="bin")
    self.copy("*", src="@libdirs", dst="lib")
#----------------------------------------------------------------------
  def build(self):
    cmake = CMake(self)
    cmake.configure()
    cmake.build()
#----------------------------------------------------------------------
  def test(self):
    if not tools.cross_building(self.settings):
      os.chdir("bin")
      self.run(f".{os.sep}integration")
#----------------------------------------------------------------------
#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#
