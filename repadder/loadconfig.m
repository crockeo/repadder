#import "loadconfig.h"

//////////////
// Includes //
#import <stdio.h>

#import "config.h"
#import "macros.h"

//////////
// Code //

// Loading a single ButtonMap.
ButtonMap loadButtonMap(FILE* fp) {
    ButtonMap bm;
    return bm;
}

// Loading a single JoystickMap.
JoystickMap loadJoystickMap(FILE* fp) {
    JoystickMap jm;
    return jm;
}

// Loading a single HatMap.
HatMap loadHatMap(FILE* fp) {
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