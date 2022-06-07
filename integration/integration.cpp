#include <templatepp/application.hpp>
#undef main

int main()
{
  templatepp::application app{};
  app.start();
  app.stop();
}
