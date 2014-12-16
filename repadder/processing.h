#ifndef _PROCESSING_H_
#define _PROCESSING_H_

//////////////
// Includes //
#import <SDL2/SDL.h>

#import "config.h"

//////////
// Code //

// Processing a single joystick event.
int processJoystickEvent(Config*, SDL_Event);

// Processing the whole event queue.
int processEventQueue(Config*);

#endif