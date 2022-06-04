@echo off

mkdir build
cd build
conan install ..
conan build ..
conan package ..
conan export-pkg .. user/channel
cd ..

cd integration
conan test . templatepp/0.4.0@user/channel
cd ..
