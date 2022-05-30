#pragma once

#ifndef _IS_DLL
#define _IS_DLL 0
#endif

#ifndef PUBLIC_API
#if _IS_DLL
#if defined _MSC_VER
#define PUBLIC_API __declspec(dllexport)
#define PRIVATE_API
#elif (defined __GNUC__ && (__GNUC__ >= 4))
#define PUBLIC_API __attribute__((visibility("default")))
#define PRIVATE_API __attribute__((visibility("hidden")))
#else
#define PUBLIC_API
#define PRIVATE_API
#endif
#else
#define PUBLIC_API
#define PRIVATE_API
#endif
#endif
