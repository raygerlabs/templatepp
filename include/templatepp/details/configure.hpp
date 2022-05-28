#pragma once

#ifndef TEMPLATEPP_DLL
#define TEMPLATEPP_DLL 0
#endif

#ifndef TEMPLATEPP_API
#if TEMPLATEPP_DLL
#if defined _MSC_VER
#define TEMPLATEPP_API __declspec(dllexport)
#define TEMPLATEPP_LOCAL
#elif (defined __GNUC__ && (__GNUC__ >= 4))
#define TEMPLATEPP_API __attribute__((visibility("default")))
#define TEMPLATEPP_LOCAL __attribute__((visibility("hidden")))
#else
#define TEMPLATEPP_API
#define TEMPLATEPP_LOCAL
#endif
#else
#define TEMPLATEPP_API
#define TEMPLATEPP_LOCAL
#endif
#endif
