#import "processing.h"

//////////////
// Includes //
#import <SDL2/SDL.h>

#import "config.h"

//////////
// Code //

// Processing a single joystick event.
int processJoystickEvent(Config* cfg, SDL_Event e) {
    if (e.type == SDL_JOYBUTTONUP || e.type == SDL_JOYBUTTONDOWN) {
        // TODO: Do something.
    } else if (e.type == SDL_JOYAXISMOTION) {
        // TODO: Do something.
    } else if (e.type == SDL_JOYHATMOTION) {
        // TODO: Do something.
    }

    return 0;
}

// Processing the whole event queue.
int processEventQueue(Config* cfg) {
    SDL_Event e;
    int n;

    while (SDL_WaitEvent(&e)) {
        if (e.type == SDL_QUIT)
            break;

        n = processJoystickEvent(cfg, e);
        if (n != 0)
            return n;
    }
    
    return 0;
}