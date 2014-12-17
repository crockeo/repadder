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
    printf("Loaded config file.\n");

    // Initializing SDL.
    if (SDL_Init(SDL_INIT_JOYSTICK) != 0) {
        printf("Failed to initialize SDL.\n");
        return 1;
    }
    printf("Initialized SDL.\n");

    // Getting the number of joysticks.
    int numJoys = SDL_NumJoysticks();
    if (numJoys < 1) {
        printf("Not enough joysticks.\n");
        return 1;
    }

    // Opening all of the joysticks.
    SDL_Joystick** joys = news(SDL_Joystick*, numJoys);
    for (int i = 0; i < numJoys; i++) {
        joys[i] = SDL_JoystickOpen(i);

        if (joys[i] == NULL) {
            printf("Failed to open joystick #%d.\n", i);
            return 1;
        }
    }
    printf("Loaded joysticks.\n");

    // Actually processing the event.
    printf("Listening for joystick events...\n");
    processEventQueue(cfg);

    // Exiting with success.
    for (int i = 0; i < numJoys; i++)
        SDL_JoystickClose(joys[i]);
    return 0;
}