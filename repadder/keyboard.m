#import "keyboard.h"

//////////////
// Includes //
#import <Cocoa/Cocoa.h>
#import <stdio.h>

//////////
// Code //

// Writing a character out to the screen.
void writeCharacter(bool press, CGKeyCode code) {
    CGEventRef e = CGEventCreateKeyboardEvent(NULL, code, press);
    CGEventPost(kCGHIDEventTap, e);
    CFRelease(e);
}