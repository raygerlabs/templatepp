#include <templatepp/application.hpp>

namespace templatepp
{
void application::start()
{
  system = sdl::make_unique_system();
}

void application::stop()
{
  system.reset();
}
} // namespace templatepp
