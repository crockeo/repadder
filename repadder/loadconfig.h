#ifndef _LOAD_CONFIG_H_
#define _LOAD_CONFIG_H_

//////////////
// Includes //
#import "config.h"

//////////
// Code //

// Loading a config from a given path.
int loadConfig(const char*, Config*);

// Saving a config to a given location.
int saveConfig(const char*, Config*);

#endif