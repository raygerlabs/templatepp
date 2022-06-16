#pragma once

#include <templatepp/config.hpp>
#include <templatepp/version.hpp>
#include <templatepp/sdl_utils.hpp>

namespace templatepp
{
/*!
 * A basic application.
 */
class TEMPLATEPP_LOCAL application
{
public:
  /*!
   * @brief Constructs application.
   */
  TEMPLATEPP_API application();
  
  /*!
   * @brief Destroys application.
   */
  TEMPLATEPP_API ~application();
  
  /*!
   * @brief Starts the application.
   * @throws system_error if initialization fails
   */
  void TEMPLATEPP_API start();

  /*!
   * @brief Stops the application.
   */
  void TEMPLATEPP_API stop();

private:
  /*!
   * Manages SDL library runtime.
   */
  sdl::unique_system system = {nullptr, nullptr};
};
} // namespace templatepp

