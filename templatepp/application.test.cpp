#include <application.hpp>

#include <gtest/gtest.h>

TEST(application_tests, graceful_start_and_shutdown)
{
  templatepp::application app{};
  ASSERT_NO_THROW(app.start());
  ASSERT_NO_THROW(app.stop());
}

