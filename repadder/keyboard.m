#import "keyboard.h"

//////////////
// Includes //
#import <Cocoa/Cocoa.h>
#import <stdio.h>

//////////
// Code //

// Writing a character out to the screen.
void writeCharacter(CGKeyCode code) {
    CGEventRef e = CGEventCreateKeyboardEvent(NULL, code, true);
    CGEventPost(kCGSessionEventTap, e);
    CFRelease(e);
}