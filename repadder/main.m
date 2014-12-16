//////////////
// Includes //
#import <SDL2/SDL.h>
#import <stdbool.h>
#import <stdio.h>

#import "keyboard.h"
#import "macros.h"
#import "f310.h"

//////////
// Code //

// Processing an event.
void processEvent(SDL_Event e) {
    if (e.type == SDL_JOYBUTTONUP || e.type == SDL_JOYBUTTONDOWN) {
        Uint8 button = e.jbutton.button;
        printf("Button: %d\n", button);

        switch (button) {
            case F310_X:
                writeCharacter(e.jbutton.state == SDL_PRESSED, KEY_A);
                break;
            case F310_A:
                writeCharacter(e.jbutton.state == SDL_PRESSED, KEY_SPACE);
                break;
            case F310_B:
                writeCharacter(e.jbutton.state == SDL_PRESSED, KEY_G);
                break;
            case F310_Y:
                writeCharacter(e.jbutton.state == SDL_PRESSED, KEY_Q);
                break;
            case F310_LEFT_BUMPER:
                writeCharacter(e.jbutton.state == SDL_PRESSED, KEY_X);
                break;
            case F310_RIGHT_BUMPER:
                writeCharacter(e.jbutton.state == SDL_PRESSED, KEY_Z);
                break;
            case F310_LEFT_TRIGGER:
                writeCharacter(e.jbutton.state == SDL_PRESSED, KEY_C);
                break;
            case F310_RIGHT_TRIGGER:
                writeCharacter(e.jbutton.state == SDL_PRESSED, KEY_V);
                break;
            case F310_START:
                writeCharacter(e.jbutton.state == SDL_PRESSED, KEY_ESCAPE);
                break;
            default:
                break;
        }
    } else if (e.type == SDL_JOYHATMOTION) {
        Uint8 value = e.jhat.value;
        printf("Hat: %d\n", value);

        int numKeys = 4;
        bool* keys = news(bool, numKeys);
        for (int i = 0; i < numKeys; i++)
            keys[i] = false;

        switch (value) {
            case F310_DPAD_UP:
                keys[0] = true;
                break;
            case F310_DPAD_DOWN:
                keys[1] = true;
                writeCharacter(true, KEY_DOWN);
                break;

            case F310_DPAD_LEFT:
                keys[2] = true;
                break;
            case F310_DPAD_RIGHT:
                keys[3] = true;
                break;

            case F310_DPAD_UP_LEFT:
                keys[0] = true;
                keys[2] = true;
                break;
            case F310_DPAD_DOWN_LEFT:
                keys[1] = true;
                keys[2] = true;
                break;

            case F310_DPAD_UP_RIGHT:
                keys[0] = true;
                keys[3] = true;
                break;
            case F310_DPAD_DOWN_RIGHT:
                keys[1] = true;
                keys[3] = true;
        }

        writeCharacter(keys[0], KEY_UP);
        writeCharacter(keys[1], KEY_DOWN);
        writeCharacter(keys[2], KEY_LEFT);
        writeCharacter(keys[3], KEY_RIGHT);
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

