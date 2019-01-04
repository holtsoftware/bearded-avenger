#include "neopixel.h"
#include "Particle.h"
#include "WarpCoreManager.h"
#define PARTICLE_USING_DEPRECATED_API


SYSTEM_MODE(AUTOMATIC);
SYSTEM_THREAD(ENABLED);

#define PIXEL_PIN D2
#define PIXEL_COUNT 110
#define PIXEL_TYPE WS2812
#define BRIGHTNESS 255 // 0 - 255

Adafruit_NeoPixel strip(PIXEL_COUNT, PIXEL_PIN, PIXEL_TYPE);

WarpCoreManager manager;

int setWarp(String command) {
    if(command == "11" || command == "-1" || command == "Off"){
        manager.SetWarp(Warps::Off);
        return 11;
    }
    else if(command == "10"){
        manager.SetWarp(Warps::Ten);
        return 10;
    }
    else if(command == "9"){
        manager.SetWarp(Warps::Nine);
        return 9;
    }
    else if(command == "8"){
        manager.SetWarp(Warps::Eight);
        return 8;
    }
    else if(command == "7"){
        manager.SetWarp(Warps::Seven);
        return 7;
    }
    else if(command == "6"){
        manager.SetWarp(Warps::Six);
        return 6;
    }
    else if(command == "5"){
        manager.SetWarp(Warps::Five);
        return 5;
    }
    else if(command == "4"){
        manager.SetWarp(Warps::Four);
        return 4;
    }
    else if(command == "3"){
        manager.SetWarp(Warps::Three);
        return 3;
    }
    else if(command == "2"){
        manager.SetWarp(Warps::Two);
        return 2;
    }
    else if(command == "1"){
        manager.SetWarp(Warps::One);
        return 1;
    }
    else{
        manager.SetWarp(Warps::Idle);
        return 0;
    }
}

// setup() runs once, when the device is first turned on.
void setup() {
    // Put initialization like pinMode and begin functions here.
    Particle.function("SetWarp", setWarp);

    byte mac[6]; // the MAC address of your Wifi shield

    WiFi.macAddress(mac);
    char buf[2];
    String message = String(itoa(mac[0],buf, 16));
    message += ":";
    message += itoa(mac[1], buf, 16);
    message += ":";
    message += itoa(mac[2], buf, 16);
    message += ":";
    message += itoa(mac[3], buf, 16);
    message += ":";
    message += itoa(mac[4], buf, 16);
    message += ":";
    message += itoa(mac[5], buf, 16);

    Particle.publish("mac", message);

    strip.setBrightness(255);
    strip.begin();
    strip.show(); // Initialize all pixels to 'off'
}

// loop() runs over and over again, as quickly as it can execute.
void loop() {
    manager.Update(strip);
}
