#include "WarpCoreManager.h"
#include "Particle.h"

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
	topRings[11].IsVertual = true;
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
	SetWarp(Warps::Idle);
}

void WarpCoreManager::SetWarp(Warps warp){
	this->warp = warp;
	switch(warp){
	case Warps::Ten:
		frames[0] = 0x0000FF;
		frames[1] = 0x0000FF;
		frames[2] = 0x0000FF;
		frames[3] = 0x0000FF;
		frames[4] = 0x000044;
		numFrames=5;
		frameIntervul = 50;
		break;
	case Warps::Nine:
		frames[0] = 0x0000FF;
		frames[1] = 0x0000FF;
		frames[2] = 0x0000FF;
		frames[3] = 0x0000FF;
		frames[4] = 0x0000FF;
		numFrames=9;
		for(int i=5;i<numFrames;i++){
			frames[i] = 0;
		}
		frameIntervul = 75;
		break;
	case Warps::Eight:
		frames[0] = 0x0000FF;
		frames[1] = 0x0000FF;
		frames[2] = 0x0000FF;
		frames[3] = 0x0000FF;
		frames[4] = 0x000055;
		numFrames=TOPRINGS;
		for(int i=5;i<numFrames;i++){
			frames[i] = 0;
		}
		frameIntervul = 75;
		break;
	case Warps::Seven:
		frames[0] = 0x0000FF;
		frames[1] = 0x0000FF;
		frames[2] = 0x0000FF;
		frames[3] = 0x0000FF;
		numFrames=TOPRINGS;
		for(int i=4;i<numFrames;i++){
			frames[i] = 0;
		}
		frameIntervul = 75;
		break;
	case Warps::Six:
		frames[0] = 0x0000FF;
		frames[1] = 0x0000FF;
		frames[2] = 0x0000FF;
		frames[3] = 0x000055;
		numFrames=TOPRINGS;
		for(int i=4;i<numFrames;i++){
			frames[i] = 0;
		}
		frameIntervul = 100;
		break;
	case Warps::Five:
		frames[0] = 0x0000FF;
		frames[1] = 0x0000FF;
		frames[2] = 0x0000FF;
		frames[3] = 0x000022;
		numFrames=TOPRINGS;
		for(int i=4;i<numFrames;i++){
			frames[i] = 0;
		}
		frameIntervul = 100;
		break;
	case Warps::Four:
		frames[0] = 0x0000FF;
		frames[1] = 0x0000FF;
		frames[2] = 0x0000FF;
		numFrames=TOPRINGS;
		for(int i=3;i<numFrames;i++){
			frames[i] = 0;
		}
		frameIntervul = 150;
		break;
	case Warps::Three:
		frames[0] = 0x0000FF;
		frames[1] = 0x0000FF;
		frames[2] = 0x000055;
		numFrames=TOPRINGS;
		for(int i=3;i<numFrames;i++){
			frames[i] = 0;
		}
		frameIntervul = 150;
		break;
	case Warps::Two:
		frames[0] = 0x0000FF;
		frames[1] = 0x0000FF;
		numFrames=TOPRINGS;
		for(int i=2;i<numFrames;i++){
			frames[i] = 0;
		}
		frameIntervul = 250;
		break;
	case Warps::One:
		frames[0] = 0x0000FF;
		frames[1] = 0x000055;
		numFrames=TOPRINGS;
		for(int i=2;i<numFrames;i++){
			frames[i] = 0;
		}
		frameIntervul = 300;
		break;
	default:
		frames[0] = 0x0000FF;
		numFrames=TOPRINGS;
		for(int i=1;i<numFrames;i++){
			frames[i] = 0;
		}
		frameIntervul = 400;
		break;
	}
}

void WarpCoreManager::Update(Adafruit_NeoPixel &strip){
	if(warp == Warps::Off){
		reset(strip, 0x000000);
		clearRings();
		strip.show();
		delay(500);
		return;
	}
	reset(strip,0x000003);
	moveRings();

	if(frames[currentFrame] > 0){
		addRing(frames[currentFrame]);
	}
	this->currentFrame++;
	if(currentFrame >= numFrames){
		currentFrame = 0;
	}

	displayRings(strip);
	addCenter(strip, 0x0000FF);
	uint32_t mi = millis();
	strip.show();
	mi = millis() - mi;
	delay(frameIntervul - mi);
}

void WarpCoreManager::displayRings(Adafruit_NeoPixel &strip){
	for(int i=0;i<TOPRINGS;i++){
		if(rings[i].IsActive){
			int position = rings[i].CurrentPosition;
			topRings[position].AddRing(strip,rings[i].Color);
			if(position < BOTTOMRINGS){
				bottomRings[position].AddRing(strip, rings[i].Color);
			}
		}
	}
}

void WarpCoreManager::moveRings(){
	for(int i=0;i<TOPRINGS;i++){
		if(rings[i].IsActive){
			rings[i].CurrentPosition--;
		}
		if(rings[i].CurrentPosition < 0){
			rings[i].IsActive = false;
		}
	}
}

void WarpCoreManager::clearRings(){
	for(int i=0;i<TOPRINGS;i++){
		if(rings[i].IsActive){
			rings[i].IsActive = false;
		}
	}
}

void WarpCoreManager::addRing(uint32_t color){
	for(int i=0;i<TOPRINGS;i++){
		if(!rings[i].IsActive){
			rings[i].CurrentPosition = TOPRINGS - 1;
			rings[i].IsActive = true;
			rings[i].Color = color;
			return;
		}
	}
}

void WarpCoreManager::reset(Adafruit_NeoPixel &strip, uint32_t c){
	uint16_t n = strip.numPixels();
	for(uint16_t i=0;i<n;i++){
		strip.setPixelColor(i,c);
	}
}

void WarpCoreManager::addCenter(Adafruit_NeoPixel &strip, uint32_t c){
	for(int i=40;i<50;i++){
		strip.setPixelColor(i, c);
	}
}
