#import "config.h"

//////////////
// Includes //
#import "macros.h"

//////////
// Code //

// Creating a new ButtonMap.
ButtonMap newButtonMap(int joy, Uint8 button, CGKeyCode target) {
    ButtonMap bm;
    
    bm.joy = joy;
    bm.button = button;
    bm.target = target;
    
    return bm;
}

// Creating a new JoystickMap.
JoystickMap newJoystickMap(int joy, Uint8 joystick, Sint16 min, Sint16 max, CGKeyCode target) {
    JoystickMap jm;
    
    jm.joy = joy;
    jm.joystick = joystick;
    jm.min = min;
    jm.max = max;
    jm.target = target;
    
    return jm;
}

// Creating a new HatMap.
HatMap newHatMap(int joy, UInt8 hat, Uint8 value, CGKeyCode target) {
    HatMap hm;
    
    hm.joy = joy;
    hm.hat = hat;
    hm.value = value;
    hm.target = target;
    
    return hm;
}

@implementation Config

// Allocating the initial Config.
- (id)init {
    // Initializing the ButtonMaps.
    _buttonMapSize = 1;
    _buttonMapCount = 0;
    _buttonMaps = news(ButtonMap, _buttonMapSize);

    // Initializing the JoystickMaps.
    _joystickMapSize = 1;
    _joystickMapCount = 0;
    _joystickMaps = news(JoystickMap, _joystickMapSize);

    // Initializing the HatMaps.
    _hatMapSize = 1;
    _hatMapCount = 0;
    _hatMaps = news(HatMap, _hatMapSize);

    return self;
};

// Adding a ButtonMap.
- (void)addButtonMap: (ButtonMap)input {
    if (_buttonMapCount >= _buttonMapSize) {
        ButtonMap* tmp = news(ButtonMap, 2 * _buttonMapSize);
        for (int i = 0; i < _buttonMapCount; i++)
            tmp[i] = _buttonMaps[i];
        free(_buttonMaps);
        _buttonMapSize *= 2;
        _buttonMaps = tmp;
    }

    _buttonMaps[_buttonMapCount] = input;
    _buttonMapCount++;
};

// Adding a JoystickMap.
- (void)addJoystickMap: (JoystickMap)input {
    if (_joystickMapCount >= _joystickMapSize) {
        JoystickMap* tmp = news(JoystickMap, 2 * _joystickMapSize);
        for (int i = 0; i < _joystickMapCount; i++)
            tmp[i] = _joystickMaps[i];
        free(_joystickMaps);
        _joystickMapSize *= 2;
        _joystickMaps = tmp;
    }
    
    _joystickMaps[_joystickMapCount] = input;
    _joystickMapCount++;
};

// Adding a HatMap.
- (void)addHatMap: (HatMap)input {
    if (_hatMapCount >= _hatMapSize) {
        HatMap* tmp = news(HatMap, 2 * _hatMapSize);
        for (int i = 0; i < _hatMapCount; i++)
            tmp[i] = _hatMaps[i];
        free(_hatMaps);
        _hatMapSize *= 2;
        _hatMaps = tmp;
    }

    _hatMaps[_hatMapCount] = input;
    _hatMapCount++;
};

@end
