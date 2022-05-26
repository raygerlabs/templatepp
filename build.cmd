@echo off
md build
cd build
conan install .. -s build_type=Release -pr:b default --build missing
conan build ..
conan package ..
cd ..