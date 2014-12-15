#ifndef _F310_H_
#define _F310_H_

//////////
// Code //

// The buttons on the right side of the controller.
const Uint8 F310_X = 0;
const Uint8 F310_A = 1;
const Uint8 F310_B = 2;
const Uint8 F310_Y = 3;

// The bumper and trigger buttons.
const Uint8 F310_LEFT_BUMPER   = 4;
const UInt8 F310_RIGHT_BUMPER  = 5;
const Uint8 F310_LEFT_TRIGGER  = 6;
const Uint8 F310_RIGHT_TRIGGER = 7;

// The select & start buttons.
const Uint8 F310_SELECT = 8;
const Uint8 F310_START  = 9;

// The left & right stick buttons.
const Uint8 F310_LEFT_STICK  = 10;
const Uint8 F310_RIGHT_STICK = 11;

// The axes.
const Uint8  F310_LEFT_STICK_X     = 0;
const SInt16 F310_LEFT_STICK_X_MIN = -32768;
const SInt16 F310_LEFT_STICK_X_MAX =  32767;

const Uint8  F310_LEFT_STICK_Y     = 0;
const SInt16 F310_LEFT_STICK_Y_MIN = -32768;
const SInt16 F310_LEFT_STICK_Y_MAX =  32767;

const Uint8  F310_RIGHT_STICK_X     = 0;
const SInt16 F310_RIGHT_STICK_X_MIN = -32768;
const SInt16 F310_RIGHT_STICK_X_MAX =  32767;

const Uint8  F310_RIGHT_STICK_Y     = 0;
const SInt16 F310_RIGHT_STICK_Y_MIN = -32768;
const SInt16 F310_RIGHT_STICK_Y_MAX =  32767;

// The different values for the hat (DPad)
const Uint8 F310_DPAD = 0;

const Uint8 F310_DPAD_NEUTRAL = 0;
const Uint8 F310_DPAD_UP      = 1;
const Uint8 F310_DPAD_RIGHT   = 2;
const Uint8 F310_DPAD_DOWN    = 4;
const Uint8 F310_DPAD_LEFT    = 8;

const UInt8 F310_DPAD_UP_RIGHT   = F310_DPAD_UP   + F310_DPAD_RIGHT;
const UInt8 F310_DPAD_DOWN_RIGHT = F310_DPAD_DOWN + F310_DPAD_RIGHT;

const UInt8 F310_DPAD_UP_LEFT   = F310_DPAD_UP   + F310_DPAD_LEFT;
const UInt8 F310_DPAD_DOWN_LEFT = F310_DPAD_DOWN + F310_DPAD_LEFT;

#endif