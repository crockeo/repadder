#include "controller.hpp"

//////////////
// Includes //
#include <SDL2/SDL.h>

//////////
// Code //

// Attempting to construct a controller at a given index.
Controller::Controller(int index) {
    this->joy = SDL_JoystickOpen(index);
    if (this->joy == nullptr)
        this->error = true;
    else
        this->error = false;
}

// Cleaning up a controller.
Controller::~Controller() {
    if (!this->isError())
        SDL_JoystickClose(this->joy);
}

// Getting the number of axes.
int Controller::getNumAxes() {
    if (this->isError())
        return -1;
    return SDL_JoystickNumAxes(this->joy);
}

// Getting the number of buttons.
int Controller::getNumButtons() {
    if (this->isError())
        return -1;

    return SDL_JoystickNumButtons(this->joy);
}

// Getting the value of an axis.
Sint16 Controller::getAxis(int index) {
    if (this->isError())
        return 0;
    return SDL_JoystickGetAxis(this->joy, index);
}

// Checking the state of a button.
bool Controller::getButton(int index) {
    if (this->isError())
        return false;
    return SDL_JoystickGetButton(this->joy, index) == 1;
}

// Checking if there was an error in creating a controller.
bool Controller::isError() {
    return this->error;
}
