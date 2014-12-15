#ifndef _KEYBOARD_H_
#define _KEYBOARD_H_

//////////////
// Includes //
#import <Cocoa/Cocoa.h>

//////////
// Code //

// Some letter keys.
const static CGKeyCode KEY_A = 0;
const static CGKeyCode KEY_C = 8;
const static CGKeyCode KEY_G = 5;
const static CGKeyCode KEY_Q = 12;
const static CGKeyCode KEY_V = 9;
const static CGKeyCode KEY_X = 7;
const static CGKeyCode KEY_Z = 6;

// The directional keys.
const static CGKeyCode KEY_LEFT  = 123;
const static CGKeyCode KEY_RIGHT = 124;
const static CGKeyCode KEY_DOWN  = 125;
const static CGKeyCode KEY_UP    = 126;

// The special keys.
const static CGKeyCode KEY_SPACE  = 49;
const static CGKeyCode KEY_ESCAPE = 53;

// Writing a character out.
void writeCharacter(CGKeyCode);

#endif