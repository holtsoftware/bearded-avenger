#include <Arduino.h>
#include <WiFi.h>
#include "config.h"
#include <WiFiUdp.h>
#include <NTPClient.h>

struct flame{
  byte pin1;
  byte pin2;
};

byte flicker[] = {180, 30, 89, 23, 255, 200, 90, 150, 60, 230, 180, 45, 90};
flame candle[] = {
  {.pin1 = GPIO_NUM_4, .pin2 = GPIO_NUM_5}
};
byte flickerSize = sizeof(flicker);
byte current = 0;
WiFiUDP ntpUDP;
NTPClient timeClient(ntpUDP);

void setup() {
  Serial.begin(115200);
  Serial.println("setup");
  WiFi.begin(SSID, PASSWORD);
  pinMode(GPIO_NUM_2, OUTPUT);
  while(WiFi.status() != WL_CONNECTED)
  {
    digitalWrite(GPIO_NUM_2, 1);
    delay(250);
    digitalWrite(GPIO_NUM_2, 0);
    delay(250);
  }
  digitalWrite(GPIO_NUM_2, 0);
  // 1
  pinMode(candle[0].pin1, OUTPUT);
  pinMode(candle[0].pin2, OUTPUT);
  // 2
  pinMode(GPIO_NUM_15, OUTPUT);
  pinMode(GPIO_NUM_16, OUTPUT);
  // 3
  pinMode(GPIO_NUM_17, OUTPUT);
  pinMode(GPIO_NUM_18, OUTPUT);
  // 4
  pinMode(GPIO_NUM_19, OUTPUT);
  pinMode(GPIO_NUM_21, OUTPUT);
  // 5
  pinMode(GPIO_NUM_22, OUTPUT);
  pinMode(GPIO_NUM_23, OUTPUT);
  // 6
  pinMode(GPIO_NUM_13, OUTPUT);
  pinMode(GPIO_NUM_12, OUTPUT);
  // 7
  pinMode(GPIO_NUM_14, OUTPUT);
  pinMode(GPIO_NUM_27, OUTPUT);
  pinMode(GPIO_NUM_26, OUTPUT);

  pinMode(GPIO_NUM_25, OUTPUT);
  pinMode(GPIO_NUM_33, OUTPUT);
  pinMode(GPIO_NUM_32, OUTPUT);
  //pinMode(5, OUTPUT);
  //digitalWrite(LED_BUILTIN, 0);
  timeClient.begin();
  timeClient.update();
  randomSeed(timeClient.getEpochTime());
  timeClient.end();
  WiFi.disconnect(true);
}

void loop() {
  Serial.println("loop");
  // put your main code here, to run repeatedly:
  auto i = random(0, flickerSize);
  analogWrite(candle[0].pin1, flicker[i]);
  i = random(0, flickerSize);
  analogWrite(candle[0].pin2, flicker[i]);
  //analogWrite(5, flicker[i]);
  delay(random(50, 100));
}
