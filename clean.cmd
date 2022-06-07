@echo off
rd /s /q build
rd /s /q integration\build
conan remove templatepp/* -f
cls
exit /b
