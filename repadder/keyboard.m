#import "keyboard.h"

//////////////
// Includes //
#import <Cocoa/Cocoa.h>
#import <stdio.h>

#import "macros.h"

//////////
// Code //

// Writing a character out to the screen.
void writeCharacter(bool press, CGKeyCode code) {
    CGEventRef e = CGEventCreateKeyboardEvent(NULL, code, press);
    CGEventPost(kCGHIDEventTap, e);
    CFRelease(e);
}

// Representing multiple writes to perform at the same time.
@implementation Writes

// Initializing a Writes.
- (id)init {
    size = 1;
    len = 0;

    states = news(bool, size);
    codes = news(CGKeyCode, size);

    return self;
}

// Adding a keycode to a writes.
- (void)addKeyCode: (bool)pressed
                  : (CGKeyCode)code {
    for (int i = 0; i < len; i++) {
        if (codes[i] == code) {
            if (!states[i])
                states[i] = pressed;
            return;
        }
    }

    if (len >= size) {
        bool* tmpStates = news(bool, size * 2);
        for (int i = 0; i < len; i++)
            tmpStates[i] = states[i];
        free(states);
        states = tmpStates;

        CGKeyCode* tmpCodes = news(CGKeyCode, size * 2);
        for (int i = 0; i < len; i++)
            tmpCodes[i] = codes[i];
        free(codes);
        codes = tmpCodes;

        size *= 2;
    }

    states[len] = pressed;
    codes[len] = code;
    len++;
};

// Performing all of the writes contained.
- (void)performWrites {
    for (int i = 0; i < len; i++)
        writeCharacter(states[i], codes[i]);
}

@end
