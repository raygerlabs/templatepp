@echo off
mkdir build
cd build
conan install .. -s build_type=Release -o with_tests=True -o with_presets=True -pr:b default --build missing
conan build ..
conan package ..
conan export-pkg .. user/channel
cd ..
exit /b
