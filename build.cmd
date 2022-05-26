@echo off
md build
cd build
conan install ..
conan build ..
conan package ..
cd ..
