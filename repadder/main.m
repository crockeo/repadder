//////////////
// Includes //
#import <SDL2/SDL.h>
#import <stdbool.h>
#import <stdio.h>

#import "keyboard.h"
#import "f310.h"

//////////
// Code //

// Processing an event.
void processEvent(SDL_Event e) {
    if (e.type == SDL_JOYBUTTONDOWN) {
        Uint8 button = e.jbutton.button;
        printf("Button: %d\n", button);

        switch (button) {
            case F310_X:
                writeCharacter((CGKeyCode)1);
                break;
            default:
                break;
        }
    }
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
        printf(" > \n");
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
    if (n == -1)
        return 1;
    
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
            } else if (e.type == SDL_JOYBUTTONDOWN && e.jbutton.button == 9) {
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

