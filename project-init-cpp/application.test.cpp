#include <application.hpp>
#include <gtest/gtest.h>

TEST(application_test, application_starts_and_stops_gracefully)
{
  rglabs::application app{};
  ASSERT_NO_THROW(app.start());
  ASSERT_NO_THROW(app.stop());
}
