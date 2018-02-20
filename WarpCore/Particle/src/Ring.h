#ifndef _RING_H_
#define _RING_H_

#include "neopixel.h"

class Ring{
public:
    int Leds[4];
    bool IsVertual=false;
    bool Skip=false;
    void AddRing(Adafruit_NeoPixel &strip, uint32_t c){
        if(!Skip){
            for(int i=0;i<4;i++){
                strip.setPixelColor(Leds[i], c);
            }
        }
    }
};

#endif
