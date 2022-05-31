@echo off
mkdir build
cd build
conan install ..
conan build ..
conan package ..
cd ..