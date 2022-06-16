
#include <gtest/gtest.h>
#include <templatepp/application.hpp>

class ApplicationTest : public ::testing::Test {
 protected:
  void SetUp() override
  {
    app.start();
  }

  void TearDown() override
  {
    app.stop();
  }

  templatepp::application app{};
};

TEST_F(ApplicationTest, GracefulStartAndStop)
{
}

//-----------------------------------------------------------------------------
