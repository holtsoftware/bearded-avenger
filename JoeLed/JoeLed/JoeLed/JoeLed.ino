/*
 Name:		JoeLed.ino
 Created:	9/19/2015 2:43:17 PM
 Author:	Adam Holt
*/

int led1PIN = 0;
int led2PIN = 1;

int min = 5;
int max = 250;
int direction = 1;

int current1 = min;
int current2 = 0;

byte flicker[] = { 180, 30, 89, 23, 255, 200, 90, 150, 60, 230, 180, 45, 90 };

int length = 13;
long loopCount = 20;

// the setup function runs once when you press reset or power the board
void setup() {
	pinMode(led1PIN, OUTPUT);
	pinMode(led2PIN, OUTPUT);
	pinMode(2, INPUT);
	analogWrite(led2PIN, 0);
	randomSeed(analogRead(2));
}

// the loop function runs over and over again until power down or reset
void loop() {
	if (direction > 0 && current1 > max) {
		direction = -1;
		//digitalWrite(led2PIN, HIGH);
	}
	if (direction < 0 && current1 < min) {
		direction = 1;
		//digitalWrite(led2PIN, LOW);
	}

	if (direction > 0) {
		analogWrite(led1PIN, current1);
		current1 += 5;
	}
	else {
		analogWrite(led1PIN, current1);
		current1 -= 5;
	}
	if (current2 > loopCount)
	{
		for (int i = 0; i < length; i++)
		{
			analogWrite(led2PIN, flicker[i] - 30);
			delay(8);
		}
		analogWrite(led2PIN, 0);
		current2 = 0;
		loopCount = random(20, 100);
	}
	else {
		current2 += 1;
	}
	//analogWrite(led2PIN, flicker[current2++]);
	delay(5);
}
