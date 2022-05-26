add_test([=[application_test.application_starts_and_stops_gracefully]=]  C:/workspace/project-init-cpp/bin/Release/project-init-cpp-tests.exe [==[--gtest_filter=application_test.application_starts_and_stops_gracefully]==] --gtest_also_run_disabled_tests)
set_tests_properties([=[application_test.application_starts_and_stops_gracefully]=]  PROPERTIES WORKING_DIRECTORY C:/workspace/project-init-cpp/tests SKIP_REGULAR_EXPRESSION [==[\[  SKIPPED \]]==])
set(  project-init-cpp-tests_TESTS application_test.application_starts_and_stops_gracefully)
