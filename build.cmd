cls
rd /s /q tmp
conan remove templatepp/* -f
mkdir tmp
conan source . -sf tmp/source
conan install . -if tmp/install -s build_type=Release -o with_tests=True -o with_presets=True -pr:b default --build missing
conan build . -sf tmp/source -if tmp/install -bf tmp/build
conan package . -sf tmp/source -if tmp/install -bf tmp/build -pf tmp/package
conan export-pkg . user/channel -sf tmp/source -if tmp/install -bf tmp/build
conan test integration templatepp/1.0.0@user/channel -tbf tmp/test --build missing
