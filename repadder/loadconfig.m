#import "loadconfig.h"

//////////////
// Includes //
#import <Cocoa/Cocoa.h>
#import <stdio.h>

#import "config.h"
#import "macros.h"

//////////
// Code //

// Loading a single ButtonMap.
ButtonMap loadButtonMap(FILE* fp) {
    int joy, button, target;

    if (fscanf(fp, "%d %d %d\n", &joy, &button, &target) < 3) {
        ButtonMap bm;
        bm.joy = -1;
        return bm;
    }

    ButtonMap bm;
    bm.joy    = (Uint8)joy;
    bm.button = (Uint8)button;
    bm.target = (CGKeyCode)target;

    return bm;
}

// Loading a single JoystickMap.
JoystickMap loadJoystickMap(FILE* fp) {
    int joy, joystick, min, max, target;

    if (fscanf(fp, "%d %d %d %d %d\n", &joy, &joystick, &min, &max, &target) < 5) {
        JoystickMap jm;
        jm.joy = -1;
        return jm;
    }

    JoystickMap jm;
    jm.joy      = (Uint8)joy;
    jm.joystick = (Uint8)joystick;
    jm.min      = (Sint16)min;
    jm.max      = (Sint16)max;
    jm.target   = (CGKeyCode)target;

    return jm;
}

// Loading a single HatMap.
HatMap loadHatMap(FILE* fp) {
    int joy, hat, value, target;

    if (fscanf(fp, "%d %d %d %d\n", &joy, &hat, &value, &target) < 4) {
        HatMap hm;
        hm.joy = -1;
        return hm;
    }

    HatMap hm;
    return hm;
}

// Loading a config from a given path.
// Return values:
//   = 0 means success.
//   > 0 means failure. There are multiple possible values:
//      * 1 means couldn't open file.
//      * 2
int loadConfig(const char* path, Config* cfg) {
    FILE* fp = fopen(path, "r");
    if (fp == NULL) {
        printf("Could not open config file at %s. :(\n", path);
        return 1;
    }

    char* buf = news(char, 8);
    while (!feof(fp)) {
        if (fscanf(fp, "%s ", buf) < 1)
            return 2;

        if (strcmp(buf, "button") == 0) {
            ButtonMap bm = loadButtonMap(fp);
            if (bm.joy == -1)
                return 3;
            addButtonMap(cfg,bm);
        } else if (strcmp(buf, "joystick") == 0) {
            JoystickMap jm = loadJoystickMap(fp);
            if (jm.joy == -1)
                return 4;
            addJoystickMap(cfg, jm);
        } else if (strcmp(buf, "hat") == 0) {
            HatMap hm = loadHatMap(fp);
            if (hm.joy == -1)
                return 5;
            addHatMap(cfg, hm);
        } else {
            return 6;
        }
    }

    fclose(fp);
    return 0;
}