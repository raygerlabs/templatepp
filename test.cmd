@echo off
cd integration
conan test . templatepp/0.4.0@user/channel -pr:b default --build missing
cd ..
