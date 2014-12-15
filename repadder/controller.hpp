#pragma once

//////////////
// Includes //
#include <SDL2/SDL.h>

//////////
// Code //

// A class to represent a given controller.
class Controller {
public:
    // Attempting to construct a controller at a given index.
    Controller(int);

    // Cleaning up a controller.
    ~Controller();

    // Getting the number of axes.
    int getNumAxes();

    // Getting the number of buttons.
    int getNumButtons();

    // Getting the value of an axis.
    Sint16 getAxis(int);

    // Checking the state of a button.
    bool getButton(int);

    // Checking if there was an error in creating a controller.
    bool isError();

private:
    SDL_Joystick* joy;
    bool error;
};
