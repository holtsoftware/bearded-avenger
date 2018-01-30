#include "WarpCoreManager.h"

WarpCoreManager::WarpCoreManager(){
	topRings[0].Skip = true;

	int led = 50;
	for(int i=1;i<6;i++){
		for(int j=0;j<4;j++){
			topRings[i].Leds[j] = led++;
		}
	}
	for(int i=10;i>=6;i--){
		for(int j=0;j<4;j++){
			topRings[i].Leds[j] = led++;
		}
	}
	topRings[11].Skip = true;
	for(int i=16;i>=12;i--){
		for(int j=0;j<4;j++){
			topRings[i].Leds[j] = led++;
		}
	}

	bottomRings[0].Skip = true;
	led = 39;
	for(int i=5;i>=1;i--){
		for(int j=0;j<4;j++){
			bottomRings[i].Leds[j] = led--;
		}
	}
	for(int i=6;i<11;i++){
		for(int j=0;j<4;j++){
			bottomRings[i].Leds[j] = led--;
		}
	}
}

void WarpCoreManager::Update(Adafruit_NeoPixel &strip){
	for(int i=16;i>=0;i--){
		strip.clear();
		topRings[i].AddRing(strip, 0x007700);
		if(i < 11){
			bottomRings[i].AddRing(strip, 0x007700);
		}
		strip.show();
		delay(500);
	}
	strip.clear();
	addCenter(strip, 0x007700);
	strip.show();
	delay(500);
}

void WarpCoreManager::addCenter(Adafruit_NeoPixel &strip, uint32_t c){
	for(int i=40;i<50;i++){
		strip.setPixelColor(i, c);
	}
}
