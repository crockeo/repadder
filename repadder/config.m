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
HatMap newHatMap(int joy, UInt8 joystick, Uint8 value, CGKeyCode target) {
    HatMap hm;
    
    hm.joy = joy;
    hm.joystick = joystick;
    hm.value = value;
    hm.target = target;
    
    return hm;
}

// Creating a new Config.
Config* newConfig() {
    Config* cfg = new(Config);
    
    cfg->buttonMapSize = 1;
    cfg->buttonMapCount = 0;
    cfg->buttonMaps = news(ButtonMap, cfg->buttonMapSize);
    
    cfg->joystickMapSize = 1;
    cfg->joystickMapCount = 0;
    cfg->joystickMaps = news(JoystickMap, cfg->joystickMapSize);
    
    cfg->hatMapSize = 1;
    cfg->hatMapCount = 0;
    cfg->hatMaps = news(HatMap, cfg->hatMapSize);
    
    return cfg;
}

// Adding a ButtonMap to a config.
void addButtonMap(Config* cfg, ButtonMap bm) {
    if (cfg->buttonMapCount >= cfg->buttonMapSize) {
        ButtonMap* tmp = news(ButtonMap, 2 * cfg->buttonMapSize);
        for (int i = 0; i < cfg->buttonMapCount; i++)
            tmp[i] = cfg->buttonMaps[i];
        free(cfg->buttonMaps);
        cfg->buttonMaps = tmp;
    }
    
    cfg->buttonMaps[cfg->buttonMapCount] = bm;
    cfg->buttonMapCount++;
}

// Adding a JoystickMap to a config.
void addJoystickMap(Config* cfg, JoystickMap jm) {
    if (cfg->joystickMapCount >= cfg->joystickMapSize) {
        JoystickMap* tmp = news(JoystickMap, 2 * cfg->joystickMapSize);
        for (int i = 0; i < cfg->joystickMapCount; i++)
            tmp[i] = cfg->joystickMaps[i];
        free(cfg->joystickMaps);
        cfg->joystickMaps = tmp;
    }
    
    cfg->joystickMaps[cfg->joystickMapCount] = jm;
    cfg->joystickMapCount++;
}

// Adding a HatMap to a config.
void addHatMap(Config* cfg, HatMap hm) {
    if (cfg->hatMapCount >= cfg->hatMapSize) {
        HatMap* tmp = news(HatMap, 2 * cfg->hatMapSize);
        for (int i = 0; i < cfg->hatMapCount; i++)
            tmp[i] = cfg->hatMaps[i];
        free(cfg->hatMaps);
        cfg->hatMaps = tmp;
    }
    
    cfg->hatMaps[cfg->hatMapCount] = hm;
    cfg->hatMapCount++;
}
