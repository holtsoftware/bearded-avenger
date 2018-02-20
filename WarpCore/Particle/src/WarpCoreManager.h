#ifndef _WARPCOREMANAGER_H_
#define _WARPCOREMANAGER_H_

#include "Ring.h"
#include "neopixel.h"

#define TOPRINGS 17
#define BOTTOMRINGS 11

struct ActiveRing{
    bool IsActive=false;
    int CurrentPosition=-1;
    uint32_t Color=0x000003;
};

enum Warps
{
    Idle=0,
    One=1,
    Two=2,
    Three=3,
    Four=4,
    Five=5,
    Six=6,
    Seven=7,
    Eight=8,
    Nine=9,
    Ten=10,
    Off=11
};

class WarpCoreManager{
public:
    WarpCoreManager();
    void Update(Adafruit_NeoPixel &strip);
    void SetWarp(Warps warp);
private:
    void addCenter(Adafruit_NeoPixel &strip, uint32_t c);
    void reset(Adafruit_NeoPixel &strip, uint32_t c);
    void moveRings();
    void addRing(uint32_t color);
    void clearRings();
    void displayRings(Adafruit_NeoPixel &strip);
    Ring topRings[TOPRINGS];
    Ring bottomRings[BOTTOMRINGS];
    ActiveRing rings[TOPRINGS];
    uint16_t frameIntervul=500;
    uint32_t frames[TOPRINGS];
    uint8_t numFrames=10;
    uint8_t currentFrame=0;
    Warps warp=Warps::Idle;
};

#endif
