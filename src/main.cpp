//////////////
// Includes //
#include <SDL2/SDL.h>
#include <iostream>

#include "controller.hpp"

//////////
// Code //

// The entry point to the application.
int main() {
    SDL_Init(SDL_INIT_EVERYTHING);

    Controller* c = new Controller(0);
    if (c->isError())
        return 1;

    std::cout << c->getNumAxes() << "\n";
    std::cout << c->getNumButtons() << "\n";

    delete c;
    return 0;

    //SDL_Joystick* joy;
    //for (int i = 0; i < SDL_NumJoysticks() > 0; i++) {
        //joy = SDL_JoystickOpen(i);

        //if (joy) {
            //std::cout << "Opened joystick #" << i << ": " << SDL_JoystickNameForIndex(i) << ".\n";
            //std::cout << "Number of Axes #" << i << ": " << SDL_JoystickNumAxes(joy) << ".\n";
            //std::cout << "Number of Buttons #" << i << ": " << SDL_JoystickNumButtons(joy) << ".\n";
            //std::cout << "Number of Balls #" << i << ": " << SDL_JoystickNumBalls(joy) << ".\n";

            //if (SDL_JoystickGetAttached(joy))
                //SDL_JoystickClose(joy);
        //} else
            //std::cout << "Couldn't open the joystick " << i << ".\n";
    //}
}
