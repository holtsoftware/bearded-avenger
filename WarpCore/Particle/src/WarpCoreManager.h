#ifndef _WARPCOREMANAGER_H_
#define _WARPCOREMANAGER_H_

#include "Ring.h"
#include "neopixel.h"

#define TOPRINGS 17
#define BOTTOMRINGS 11

class WarpCoreManager{
public:
    WarpCoreManager();
    void Update(Adafruit_NeoPixel &strip);

private:
    void addCenter(Adafruit_NeoPixel &strip, uint32_t c);
    Ring topRings[TOPRINGS];
    Ring bottomRings[BOTTOMRINGS];
};

#endif
