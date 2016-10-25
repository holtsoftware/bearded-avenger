// This #include statement was automatically added by the Particle IDE.
#include "neopixel/neopixel.h"

#define LED_COUNT 27
#define PIN D0

Adafruit_NeoPixel leds = Adafruit_NeoPixel(LED_COUNT, PIN, WS2812);

int colors[] = { 
    0xFF0000, // red
    0x00FF00, // green
    0x0000FF, // blue
    0x483d8b,
    0xffa500, // orange
    0xFF00BF,
    0xA4A4A4,
    0xF4FA58,
    0x08088A,
    0xDF0101
};

String phrases[] = {
    "help me",
    "where am i",
    "i can hear you but dont see you",
    "help the demogorgon is coming",
    "its so dark here"
};

int phrasesCount = 5;

String nextPhrase;



int colorsSize = sizeof(colors) / sizeof(colors[0]);

int charToLed(char letter){
    if(letter == ' ' || letter == '1'){
        return 26;
    }
    return letter - 'a';
}

void selectNextPhrase(){
    int index = rand() % phrasesCount;
    nextPhrase = phrases[index];
}

int incomingMessage(String message){
    nextPhrase = message;
    return 0;
}

void setup() {
    randomSeed(analogRead(A0));
    leds.begin();
    leds.show();
    Particle.function("message", incomingMessage);
    selectNextPhrase();
}

void loop() {
    flash();
    String phrase = nextPhrase;
    nextPhrase = NULL;
    int index=0;
    char c;
    while((c = phrase[index++])){
        showLetter(c);
    }
    flash();
    
    unsigned long generateNext = ((rand() % 900000) + 900000) + millis();
    
    while(nextPhrase == NULL && generateNext > millis()) {
        delay(500);
    }
    
    if(nextPhrase == NULL){
        selectNextPhrase();
    }
}

void allOn(){
    int index = rand() % colorsSize;
    int c = colors[index];
    
    leds.clear();
    for(int i=0;i<=255;i++){
        for(int j=0;j<LED_COUNT;j++){
            leds.setColorDimmed(j, c >> 16, c >> 8, c, i);
        }
        leds.show();
        delay(2);
    }
    delay(5000);
    for(int i=255;i>=0;i--){
        for(int j=0;j<LED_COUNT;j++){
            leds.setColorDimmed(j, c >> 16, c >> 8, c, i);
        }
        leds.show();
        delay(2);
    }
}

int getColor(){
    int index = rand() % colorsSize;
    int c = colors[index];
    return c;
}

void flash(){
    int count = (rand() % 75) + 25;
    for(int i=0;i<count;i++){
        allRandomColor(50);
        delay(20);
        allRandomColor(255);
        delay(20);
        allRandomColor(100);
        delay(20);
        allRandomColor(255);
        delay(20);
        allRandomColor(55);
        delay(20);
        allRandomColor(0);
        delay(20);
    }
}

void allRandomColor(int brightness){
    int c;
    
    for(int i=0;i<=LED_COUNT;i++){
        c = getColor();
        leds.setColorDimmed(i, c >> 16, c >> 8, c, brightness);
    }
    leds.show();
}

void showLetter(char letter){
    int led = charToLed(letter);
    int index = rand() % colorsSize;
    int c = colors[index];
    leds.clear();
    for(int i=0;i<=255;i++){
        leds.setColorDimmed(led, c >> 16, c >> 8, c, i);
        leds.show();
        delay(2);
    }
    delay(1000);
    for(int i=255;i>=0;i--){
        leds.setColorDimmed(led, c >> 16, c >> 8, c, i);
        leds.show();
        delay(2);
    }
}