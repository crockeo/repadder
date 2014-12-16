#ifndef _MACROS_H_
#define _MACROS_H_

// Creating a new value.
#define new(Type) (Type*)malloc(sizeof(Type))

// Creating a bunch of a new value.
#define news(Type, n) (Type*)malloc(sizeof(Type) * n)

#endif