//-----------------------------------------------------------------------------
#include <templatepp/application.hpp>
//-----------------------------------------------------------------------------
namespace templatepp
{
application::application() : system{sdl::make_unique_system(SDL_INIT_VIDEO)}
{
}

application::~application()
{
  system.reset();
}

void application::start()
{
}

void application::stop()
{
}
} // namespace templatepp
//-----------------------------------------------------------------------------
