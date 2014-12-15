//////////////
// Includes //
#include <SDL2/SDL.h>
#include <iostream>

#include "controller.hpp"

//////////
// Code //

// Processing an event.
void processEvent(SDL_Event e) {
    if (e.type == SDL_KEYDOWN) {
        if (e.key.keysym.sym == SDLK_a)
            std::cout << "A DOWN!!!\n";
    } else if (e.type == SDL_JOYBUTTONDOWN) {
        std::cout << "Button: " << (int)e.jbutton.button << "\n";
    } else if (e.type == SDL_JOYAXISMOTION) {
        std::cout << "Axis: " << (int)e.jaxis.axis << "\n";
        std::cout << "  Val: " << (int)e.jaxis.value << "\n";
    } else if (e.type == SDL_JOYHATMOTION) {
        std::cout << "Hat: " << (int)e.jhat.hat << "\n";
        std::cout << "  Val: " << (int)e.jhat.value << "\n";
    }
}

// The entry point to the application.
int main() {
    if (SDL_Init(SDL_INIT_JOYSTICK) == -1)
        return 1;

    if (SDL_NumJoysticks() < 1) {
        std::cout << "Not enough joysticks!\n";
        return 1;
    }

    SDL_Joystick* joy = SDL_JoystickOpen(0);
    if (joy == nullptr) {
        std::cout << "Couldn't open joystick 0.\n";
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
