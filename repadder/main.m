//////////////
// Includes //
#include <SDL2/SDL.h>
#include <stdbool.h>
#include <stdio.h>

//////////
// Code //

// Creating a new piece of stuff.
#define new(Type) (*Type)malloc(sizeof(Type))

// Processing an event.
void processEvent(SDL_Event e) {
    if (e.type == SDL_JOYBUTTONDOWN)
        printf("Button: %d\n", (int)e.jbutton.button);
    else if (e.type == SDL_JOYAXISMOTION)
        printf("Axis: %d\n  Val: %d\n", (int)e.jaxis.axis, (int)e.jaxis.value);
    else if (e.type == SDL_JOYHATMOTION)
        printf("Hat: %d\n  Val: %d\n", (int)e.jhat.hat, (int)e.jhat.value);
}

// Choosing a joystick index.
int chooseJoystick() {
    int max = SDL_NumJoysticks();
    if (max < 1) {
        printf("Not enough joysticks!\n");
        return -1;
    }
    
    for (int i = 0; i < max; i++) {
        SDL_Joystick* joy = SDL_JoystickOpen(i);
        printf("%s (%d)\n", SDL_JoystickName(joy), i + 1);
        SDL_JoystickClose(joy);
    }
    
    int joy = 0;
    while (joy == 0 || joy > max) {
        printf(" > ");
        joy = 1;
        // std::cin >> joy;
    }
    
    return joy - 1;
}

// The entry point to the application.
int main() {
    if (SDL_Init(SDL_INIT_JOYSTICK) == -1)
        return 1;
    
    int n = chooseJoystick();
    if (n == -1) {
        printf("Not enough joysticks.\n");
        return 1;
    }
    
    SDL_Joystick* joy = SDL_JoystickOpen(n);
    if (joy == NULL) {
        printf("Couldn't open joystick %d.\n", n + 1);
        return 1;
    }
    
    // Looping through and processing all of the events.
    SDL_Event e;
    bool running = true;
    while (running) {
        // Polling and reacting to events.
        while (SDL_PollEvent(&e) != 0) {
            if (e.type == SDL_QUIT) {
                running = false;
                break;
            } else if (e.type == SDL_KEYDOWN && e.key.keysym.sym == SDLK_ESCAPE) {
                running = false;
                break;
            }
            
            processEvent(e);
        }
    }
    
    // Cleaning up.
    SDL_Quit();
    return 0;
}

