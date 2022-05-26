@echo off
md build
cd build
conan install ..
cmake -DCMAKE_BUILD_TYPE=Release ..
cmake --build . --config Release
cmake --install . --config Release --prefix install
ctest -VV -C Release
cpack
cd ..
