#ifndef _SERVER_H_
#define _SERVER_H_
#include <Arduino.h>

class DogServer
{
public:
	void init();
	void handleClient();
	void setCurrentlyOn(bool isOn);
	bool getCurrentlyOn();

	int getOnAt();
	int getOffAt();

	void setTempreture(float tempreture);
	float getTempreture();

private:

    void handleStatus();
    void handleEditGet();
    void handleEditPost();

	bool currentlyOn = false;
	int onAt = 70;
	int offAt = 75;
	float tempreture = 60;
};

#endif