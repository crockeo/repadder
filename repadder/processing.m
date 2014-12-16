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
    bool running = true;
    SDL_Event e;
    
    while (running) {
        while (SDL_PollEvent(&e)) {
            if (e.type == SDL_QUIT) {
                running = false;
                break;
            }
            
            int n = processJoystickEvent(cfg, e);
            if (n != 0)
                return n;
        }
        
        // Do some other stuff here?
    }
    
    return 0;
}