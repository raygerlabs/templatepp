#pragma once

#ifndef RGLABS_DLL
#define RGLABS_DLL 0
#endif

#ifndef RGLABS_API
#if RGLABS_DLL
#if defined _MSC_VER
#define RGLABS_API __declspec(dllexport)
#define RGLABS_LOCAL
#elif (defined __GNUC__ && (__GNUC__ >= 4))
#define RGLABS_API __attribute__((visibility("default")))
#define RGLABS_LOCAL __attribute__((visibility("hidden")))
#else
#define RGLABS_API
#define RGLABS_LOCAL
#endif
#else
#define RGLABS_API
#define RGLABS_LOCAL
#endif
#endif
