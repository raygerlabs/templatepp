@echo off
md build
cd build
cmd /c conan install ..
cmd /c conan build ..
cmd /c conan package ..
cmd /c conan export-pkg .. user/channel
cd ..
cmd /c conan test test_package templatepp/0.3.0@user/channel
