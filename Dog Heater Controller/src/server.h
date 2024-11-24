#ifndef _SERVER_H_
#define _SERVER_H_
#include <Arduino.h>
#include <functional>

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

    void logTempreture(float temp);

private:

    void handleStatus();
    void handleEditGet();
    void handleEditPost();
    void handleAnyFile();
    void handleLogJson();
    void sendFilesArray(const String &root, const String &currentDir, bool firstSent);

    void sendFile(const String &file,const  String &contentType, std::function<String(const String&)> callback);
    void sendFile(const String &file,const  String &contentType);
    void sendBinaryFile(const String &file, const String &contentType);

	bool currentlyOn = false;
	int onAt = 70;
	int offAt = 75;
	float tempreture = 60;
};

#endif