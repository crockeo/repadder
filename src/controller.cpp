#include "controller.hpp"

//////////////
// Includes //
#include <SDL2/SDL.h>

//////////
// Code //

// Attempting to construct a controller at a given index.
Controller::Controller(int index) {
    this->joy = SDL_JoystickOpen(index);
}

// Cleaning up a controller.
Controller::~Controller() {
    if (!this->isError())
        SDL_JoystickClose(this->joy);
}

// Getting the number of axes.
int Controller::getNumAxes() {
    if (!this->isError())
        SDL_JoystickNumAxes(this->joy);
    return -1;
}

// Getting the number of buttons.
int Controller::getNumButtons() {
    if (!this->isError())
        SDL_JoystickNumButtons(this->joy);
    return -1;
}

// Getting the value of an axis.
Sint16 Controller::getAxis(int index) {
    if (!this->isError())
        return SDL_JoystickGetAxis(this->joy, index);
    return 0;
}

// Checking the state of a button.
bool Controller::getButton(int index) {
    if (!this->isError())
        return SDL_JoystickGetButton(this->joy, index) == 1;
    return false;
}

// Checking if there was an error in creating a controller.
bool Controller::isError() {
    return this->error;
}
