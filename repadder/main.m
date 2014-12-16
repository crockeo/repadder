//////////////
// Includes //
#import <SDL2/SDL.h>
#import <stdbool.h>
#import <stdio.h>

#import "loadconfig.h"
#import "processing.h"
#import "config.h"
#import "macros.h"

//////////
// Code //

// The entry point to the application.
int main(int argc, const char** argv) {
    // Ensuring that the proper number of arguments have been supplied.
    if (argc != 2) {
        printf("Failed to specify config file!\n");
        return 1;
    }

    // Opening a config.
    Config* cfg = [Config alloc];
    if (loadConfig(argv[1], cfg) != 0)
        return 1;

    // Initializing SDL.
    if (SDL_Init(SDL_INIT_JOYSTICK) != 0) {
        printf("Failed to initialize SDL.\n");
        return 1;
    }

    // Opening all of the joysticks.
    SDL_Joystick** joys = news(SDL_Joystick*, [cfg joysticksNum]);
    for (int i = 0; i < [cfg joysticksNum]; i++) {
        joys[i] = SDL_JoystickOpen([cfg joysticks][i]);
        if (joys[i] == NULL) {
            printf("Failed to open Joystick #%d!\n", [cfg joysticks][i]);
            return 1;
        }
    }

    // Actually processing the event.
    processEventQueue(cfg);

    // Exiting with success.
    return 0;
}