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
    hm.joy    = (Uint8)joy;
    hm.hat    = (Uint8)hat;
    hm.value  = (Uint8)value;
    hm.target = (CGCharCode)target;
    
    return hm;
}

// Loading a config from a given path.
// Return values:
//   = 0 means success.
//   > 0 means failure. There are multiple possible values:
//      * 1 means couldn't open file.
//      * 2 means it failed to match a config type.
//      * 3 means it failed after matching a button.
//      * 4 means it failed after matching a joystick.
//      * 5 means it failed after matching a hat.
//      * 6 means it couldn't match a line.
int loadConfig(const char* path, Config* cfg) {
    FILE* fp = fopen(path, "r");
    if (fp == NULL) {
        printf("Could not open config file at %s. :(\n", path);
        return 1;
    }

    char* buf = news(char, 8);
    while (!feof(fp)) {
        if (fscanf(fp, "%s ", buf) < 1) {
            printf("Failed to match a config type.\n");
            return 2;
        }

        if (strcmp(buf, "#") == 0) {
            char c;
            do {
                c = (char)fgetc(fp);
            } while (c != '\n' && c != '\r');
        } else if (strcmp(buf, "button") == 0) {
            ButtonMap bm = loadButtonMap(fp);
            if (bm.joy == -1) {
                printf("Failed to load a button.\n");
                return 3;
            }
            [cfg addButtonMap:bm];
        } else if (strcmp(buf, "joystick") == 0) {
            JoystickMap jm = loadJoystickMap(fp);
            if (jm.joy == -1) {
                printf("Failed to load a joystick.\n");
                return 4;
            }
            [cfg addJoystickMap:jm];
        } else if (strcmp(buf, "hat") == 0) {
            HatMap hm = loadHatMap(fp);
            if (hm.joy == -1) {
                printf("Failed to load a hat.\n");
                return 5;
            }
            [cfg addHatMap:hm];
        } else {
            printf("Unrecognized line.\n");
            return 6;
        }
    }

    fclose(fp);
    return 0;
}

// Saving a config to a given location.
int saveConfig(const char* path, Config* cfg) {
    FILE* fp = fopen(path, "w");
    if (fp == NULL) {
        printf("Failed to open config file '%s' for writing.\n", path);
        return 1;
    }
    
    // Writing all of the buttons.
    for (int i = 0; i < [cfg buttonMapCount]; i++)
        fprintf(fp, "button %d %d %d",
                [cfg buttonMaps][i].joy,
                [cfg buttonMaps][i].button,
                [cfg buttonMaps][i].target);
    
    // Writing all of the joysticks.
    for (int i = 0; i < [cfg joystickMapCount]; i++)
        fprintf(fp, "joystick %d %d %d %d %d",
                [cfg joystickMaps][i].joy,
                [cfg joystickMaps][i].joystick,
                [cfg joystickMaps][i].min,
                [cfg joystickMaps][i].max,
                [cfg joystickMaps][i].target);
    
    // Writing all of the hats.
    for (int i = 0; i < [cfg hatMapCount]; i++)
        fprintf(fp, "hat %d %d %d %d",
                [cfg hatMaps][i].joy,
                [cfg hatMaps][i].hat,
                [cfg hatMaps][i].value,
                [cfg hatMaps][i].target);
    
    // TODO: Complete
    return 0;
}