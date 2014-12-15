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
                writeCharacter(KEY_A);
                break;
            case F310_A:
                writeCharacter(KEY_SPACE);
                break;
            case F310_B:
                writeCharacter(KEY_G);
                break;
            case F310_Y:
                writeCharacter(KEY_Q);
                break;
            case F310_LEFT_BUMPER:
                writeCharacter(KEY_X);
                break;
            case F310_RIGHT_BUMPER:
                writeCharacter(KEY_Z);
                break;
            case F310_LEFT_TRIGGER:
                writeCharacter(KEY_C);
                break;
            case F310_RIGHT_TRIGGER:
                writeCharacter(KEY_V);
                break;
            case F310_START:
                writeCharacter(KEY_ESCAPE);
                break;
            default:
                break;
        }
    } else if (e.type == SDL_JOYHATMOTION) {
        Uint8 value = e.jhat.value;

        switch (value) {
            case 1:
                writeCharacter(KEY_UP);
                break;
            case 2:
                writeCharacter(KEY_RIGHT);
                break;
            case 4:
                writeCharacter(KEY_DOWN);
                break;
            case 8:
                writeCharacter(KEY_LEFT);
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
            } else if (e.type == SDL_JOYBUTTONDOWN && e.jbutton.button == F310_SELECT) {
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

