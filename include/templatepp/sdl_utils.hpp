//-----------------------------------------------------------------------------
#pragma once
//-----------------------------------------------------------------------------
#if defined _MSC_VER
#pragma warning(push, 0)
#endif
#include <SDL2/SDL.h>
#if defined _MSC_VER
#pragma warning(pop)
#endif

#include <memory>
#include <system_error>
//-----------------------------------------------------------------------------
namespace sdl
{
template<typename Ctor, typename Dtor, typename... Args>
auto make_unique_resource(Ctor ctor, Dtor dtor, Args&&... args)
{
  auto res = ctor(std::forward<Args>(args)...);
  if (!res)
  {
    throw std::system_error(errno, std::system_category());
  }
  return std::unique_ptr<std::decay_t<decltype(*res)>, decltype(dtor)>(res,
                                                                       dtor);
}
//-----------------------------------------------------------------------------
using SDL_System = int;
SDL_System* SDL_CreateSystem(Uint32 flags = SDL_INIT_EVERYTHING)
{
  return new SDL_System{SDL_Init(flags)};
}

void SDL_DestroySystem(SDL_System* system)
{
  if (system)
  {
    delete system;
    SDL_Quit();
  }
}
//-----------------------------------------------------------------------------
using unique_system = std::unique_ptr<SDL_System, decltype(&SDL_DestroySystem)>;
unique_system make_unique_system(std::uint32_t flags = SDL_INIT_EVERYTHING)
{
  return make_unique_resource(SDL_CreateSystem, SDL_DestroySystem, flags);
}
} // namespace sdl
//-----------------------------------------------------------------------------
