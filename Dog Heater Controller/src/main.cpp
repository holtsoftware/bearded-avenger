#include <Arduino.h>
#include <EEPROM.h>
#include "server.h"
#include <LittleFS.h>
#include <Ticker.h>

#define arraySize 10
int reading[arraySize];

long long calulated = 0;

float analogReading = 0;

bool heaterOn = false;

int onAt = 70;
int offAt = 75;

DogServer server;
Ticker backgroundTask;
void checkTemp();

void setup()
{
	// put your setup code here, to run once:
	Serial.begin(115200); // initialize port serial at 9600 Bauds.

	pinMode(A0, INPUT);
	pinMode(D4, OUTPUT);

	Serial.println();

	if (!LittleFS.begin())
	{
		Serial.println("Failed to init LittleFS");
	}

	Serial.print("On At: ");
	Serial.println((String)server.getOnAt());
	Serial.print("Off At: ");
	Serial.println((String)server.getOffAt());
	server.init();

	// Start a background task using Ticker (e.g., blink LED every 1 second)
	backgroundTask.attach(30, checkTemp);
}

void checkTemp()
{
	// put your main code here, to run repeatedly:

	for (int i = 0; i < arraySize; i++)
	{
		reading[i] = analogRead(A0);
	}

	// Print temperature in port serial

	calulated = 0;
	for (int i = 0; i < arraySize; i++)
	{
		calulated += reading[i];
	}

	analogReading = (calulated / arraySize);
	// This is not a perfect formula but it will be close enough
	server.setTempreture(0.00026 * (analogReading * analogReading) - 0.2149 * analogReading + 73.3542);

	Serial.print("Analog Reading: ");
	Serial.print((String)analogReading);
	Serial.print(" (");
	Serial.print((String)server.getTempreture());
	Serial.println(")");
	Serial.print("----------------------");
	Serial.println();

	if (server.getTempreture() < server.getOnAt() && !server.getCurrentlyOn())
	{
		digitalWrite(D4, 1);
		server.setCurrentlyOn(true);
		Serial.println("Heater On");
	}
	else if (server.getTempreture() > server.getOffAt() && server.getCurrentlyOn())
	{
		digitalWrite(D4, 0);
		server.setCurrentlyOn(false);
		Serial.println("Heater Off");
	}

}

void loop()
{
	server.handleClient();
}
