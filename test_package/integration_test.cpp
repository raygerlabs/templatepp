#include <application.hpp>

int main(int argc, char* argv[])
{
  templatepp::application app{};
  app.start();
  app.stop();
}
