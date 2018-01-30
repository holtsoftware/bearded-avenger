#include "neopixel.h"
#include "Particle.h"
#include "WarpCoreManager.h"


SYSTEM_MODE(AUTOMATIC);

#define PIXEL_PIN D2
#define PIXEL_COUNT 110
#define PIXEL_TYPE WS2812
#define BRIGHTNESS 255 // 0 - 255

Adafruit_NeoPixel strip(PIXEL_COUNT, PIXEL_PIN, PIXEL_TYPE);

WarpCoreManager manager;

// setup() runs once, when the device is first turned on.
void setup() {
    // Put initialization like pinMode and begin functions here.
    strip.setBrightness(255);
    strip.begin();
    strip.show(); // Initialize all pixels to 'off'
}

// loop() runs over and over again, as quickly as it can execute.
void loop() {
    manager.Update(strip);
}
