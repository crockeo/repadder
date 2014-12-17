#ifndef _CONFIG_H_
#define _CONFIG_H_

/////////////
// Imports //
#import <Cocoa/Cocoa.h>
#import <SDL2/SDL.h>

//////////
// Code //

// A struct to represent a button map.
typedef struct ButtomMap {
    int joy;
    Uint8 button;
    CGKeyCode target;
} ButtonMap;

// Creating a new ButtonMap.
ButtonMap newButtonMap(int, Uint8, CGKeyCode);

// A struct to represent a joystick map.
typedef struct JoystickMap {
    int joy;
    UInt8 joystick;
    Sint16 min, max;
    CGKeyCode target;
} JoystickMap;

// Creating a new JoystickMap.
JoystickMap newJoystickMap(int, Uint8, Sint16, Sint16, CGKeyCode);

// A struct to represent a hat map.
typedef struct HatMap {
    int joy;
    UInt8 hat;
    UInt8 value;
    CGKeyCode target;
} HatMap;

// Creating a new HatMap.
HatMap newHatMap(int, UInt8, Uint8, CGKeyCode);

// A struct to represent keymaps.
@interface Config : NSObject

// Buttons.
@property int buttonMapSize;
@property int buttonMapCount;
@property ButtonMap* buttonMaps;

// Joysticks.
@property int joystickMapSize;
@property int joystickMapCount;
@property JoystickMap* joystickMaps;

// Hats.
@property int hatMapSize;
@property int hatMapCount;
@property HatMap* hatMaps;

// Allocating the initial Config.
+ (id)init;

// Adding a ButtonMap.
- (void)addButtonMap: (ButtonMap)input;

// Adding a JoystickMap.
- (void)addJoystickMap: (JoystickMap)input;

// Adding a HatMap.
- (void)addHatMap: (HatMap)input;

@end

#endif