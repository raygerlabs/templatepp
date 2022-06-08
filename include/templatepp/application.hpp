//-----------------------------------------------------------------------------
#pragma once
//-----------------------------------------------------------------------------
#include <templatepp/config.hpp>
#include <templatepp/sdl_utils.hpp>
//-----------------------------------------------------------------------------
namespace templatepp
{
class TEMPLATEPP_LOCAL application
{
public:
  void TEMPLATEPP_API start();
  void TEMPLATEPP_API stop();

private:
  sdl::unique_system system = {nullptr, nullptr};
};
} // namespace templatepp
//-----------------------------------------------------------------------------
