#pragma once

#if defined _MSC_VER
#pragma warning(push, 0)
#endif
#define SDL_MAIN_HANDLED
#include <SDL2/SDL.h> // SDL_Init, SDL_Quit
#if defined _MSC_VER
#pragma warning(pop)
#endif

#include <memory>       // unique_ptr, forward, decay
#include <system_error> // system_error, system_category

namespace sdl
{
/*!
 * @brief Constructs a specific SDL resource.
 *
 * @param ctor the function that creates the SDL resource
 * @param dtor the function that destroys the SDL resource
 * @param args SDL subsystem initialization flags
 *
 * @returns unique pointer that owns the SDL resource
 *
 * @throws system_error if initialization fails
 */
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

/*!
 * A handle for SDL library.
 * For storing the status code of the SDL_Init() function.
 */
using SDL_Handle = int*;

/*!
 * @brief Initializes SDL library and creates handle for it.
 * @param flags subsystem initialization flags
 * @returns handle for SDL library
 */
SDL_Handle SDL_CreateSDL(Uint32 flags = SDL_INIT_EVERYTHING)
{
  SDL_SetMainReady();
  return new std::remove_pointer_t<SDL_Handle>{SDL_Init(flags)};
}

/*!
 * @brief Stops SDL library and deletes handle for it.
 * @param handle the handle for SDL library
 */
void SDL_DestroySDL(SDL_Handle handle)
{
  if (handle)
  {
    delete handle;
    SDL_Quit();
  }
}

/*!
 * A unique pointer type for managing SDL startup and shutdown.
 */
using unique_system = std::unique_ptr<std::remove_pointer_t<SDL_Handle>,
                                      decltype(&SDL_DestroySDL)>;

/*!
 * @brief Creates a unique pointer that manages SDL library lifetime.
 * @param flags subsystem initialization flags
 * @returns unique system type
 * @throws system_error if SDL library initialization fails
 */
unique_system make_unique_system(std::uint32_t flags = SDL_INIT_EVERYTHING)
{
  return make_unique_resource(SDL_CreateSDL, SDL_DestroySDL, flags);
}
} // namespace sdl
