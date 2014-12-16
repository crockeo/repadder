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
    UInt8 joystick;
    UInt8 value;
    CGKeyCode target;
} HatMap;

// Creating a new HatMap.
HatMap newHatMap(int, UInt8, Uint8, CGKeyCode);

// A struct to represent keymaps.
typedef struct Config {
    int buttonMapSize;
    int buttonMapCount;
    ButtonMap* buttonMaps;
    
    int joystickMapSize;
    int joystickMapCount;
    JoystickMap* joystickMaps;
    
    int hatMapSize;
    int hatMapCount;
    HatMap* hatMaps;
} Config;

// Creating a new Config.
Config* newConfig();

// Adding a ButtonMap to a config.
void addButtonMap(Config*, ButtonMap);

// Adding a JoystickMap to a config.
void addJoystickMap(Config*, JoystickMap);

// Adding a HatMap to a config.
void addHatMap(Config*, HatMap);

#endif