@echo off
mkdir build
cd build
conan install ..
conan build ..
conan export-pkg .. user/channel
cd ..
cd test
mkdir build
cd build
conan test .. templatepp/0.4.0@user/channel
cd ..
cd ..

