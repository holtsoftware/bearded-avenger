#include <wiringPi.h>

int main(void)
{
	wiringPiSetup();
	pinMode(0, OUTPUT);
	digitalWrite(1, HIGH);
	delay(500);
	return 0;
}
