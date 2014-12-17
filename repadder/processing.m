#import "processing.h"

//////////////
// Includes //
#import <SDL2/SDL.h>

#import "keyboard.h"
#import "config.h"

//////////
// Code //

// Processing an SDL_JoyButtonEvent.
int processJoyButtonEvent(Config* cfg, SDL_JoyButtonEvent e) {
    ButtonMap bm;
    for (int i = 0; i < cfg.buttonMapCount; i++) {
        bm = cfg.buttonMaps[i];
        if (bm.joy == e.which && bm.button == e.button) {
            writeCharacter(e.state == 1, bm.target);
            break;
        }
    }

    return 0;
}

// Processing an SDL_JoyAxisEvent.
int processJoyAxisEvent(Config* cfg, SDL_JoyAxisEvent e) {
    JoystickMap jm;
    for (int i = 0; i < cfg.joystickMapCount; i++) {
        jm = cfg.joystickMaps[i];
        if (jm.joy == e.which && jm.joystick == e.axis) {
            writeCharacter(jm.min <= e.value && e.value <= jm.max, jm.target);
            break;
        }
    }

    return 0;
}

// Processing an SDL_JoyHatEvent.
int processJoyHatEvent(Config* cfg, SDL_JoyHatEvent e) {
    HatMap hm;
    for (int i = 0; i < cfg.hatMapCount; i++) {
        hm = cfg.hatMaps[i];
        if (hm.joy == e.which && hm.hat == e.hat) {
            if (hm.value == e.value) {
                writeCharacter(true, hm.target);
                break;
            } else
                writeCharacter(false, hm.target);
        }
    }

    return 0;
}

// Processing a single joystick event.
int processJoystickEvent(Config* cfg, SDL_Event e) {
    if (e.type == SDL_JOYBUTTONUP || e.type == SDL_JOYBUTTONDOWN)
        return processJoyButtonEvent(cfg, e.jbutton);
    else if (e.type == SDL_JOYAXISMOTION)
        return processJoyAxisEvent(cfg, e.jaxis);
    else if (e.type == SDL_JOYHATMOTION)
        return processJoyHatEvent(cfg, e.jhat);

    return 0;
}

// Processing the whole event queue.
int processEventQueue(Config* cfg) {
    SDL_Event e;
    int n;

    while (SDL_WaitEvent(&e)) {
        if (e.type == SDL_QUIT)
            break;

        n = processJoystickEvent(cfg, e);
        if (n != 0)
            return n;
    }
    
    return 0;
}