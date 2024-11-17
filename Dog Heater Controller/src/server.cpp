#include <ESP8266WiFi.h>
#include <ESP8266WebServer.h>
#include <EEPROM.h>
#include <LittleFS.h>
#include <functional>
#include "server.h"

#define STARTADDRESS 3
#define WIFIFILE "/wifi.txt"

#define ONAT_FILE "/onAt.txt"
#define OFFAT_FILE "/offAt.txt"

// Network credentials
const char *ssid = "DogHouse";		 // Name of the configuration network
const char *password = "@Password1"; // Password for the configuration network

ESP8266WebServer webServer(80);

// HTML content for configuration page
String htmlPage = R"rawliteral(
<!DOCTYPE html>
<html>
<head>
	<title>Dog Heater Controller</title>
</head>
<body>
	<h1>Welcome to the Dog Heater Controller</h1>
	<p>Please enter the wifi info to configure the network to connect to</p>
	<form action="/save" method="POST">
		Wi-Fi SSID: <input type="text" name="ssid" /><br>
		Wi-Fi Password: <input type="password" name="password" /><br>
		<input type="submit" value="Save">
	</form>
</body>
</html>
)rawliteral";

String statusPage = R"rawliteral(
<!DOCTYPE html>
<html data-bs-theme="dark">
<head>
	<meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Dog House Heater</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
</head>
<body>
	<div class="container">
		<h1>Dog House Heater</h1>
		<ul class="list-group">
			<li class="list-group-item">Heater Status: {3}</li>
			<li class="list-group-item">Tempreture: {0}</li>
			<li class="list-group-item">On At: {1} <a class="btn btn-primary" href="/edit" role="button">Edit</a></li>
			<li class="list-group-item">Off At: {2}</li>
		</ul>
	</div>
	 <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
	 <script type="text/javascript">
	 	setTimeout(function(){
			window.location = window.location;
		}, 5000);
	 </script>
</body>
</html>
)rawliteral";

String editPage = R"rawliteral(
<!DOCTYPE html>
<html data-bs-theme="dark">
<head>
	<meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Dog House Heater</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
</head>
<body>
	<div class="container">
		<h1>Dog House Heater</h1>
		<form action="/edit" method="POST">
			<div class="mb-3">
				<label for="onAt" class="form-label">On At:</label>
				<input type="number" class="form-control" id="onAt" name="onAt" value="{0}">
			</div>
			<div class="mb-3">
				<label for="offAt" class="form-label">Off At:</label>
				<input type="number" class="form-control" id="offAt" name="offAt" value="{1}">
			</div>
			<div class="mb-3">
				<button type="submit" class="btn btn-primary">Save</button>
			</div>
		</form> 
	</div>
	 <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
</body>
</html>
)rawliteral";

void saveIntToFile(const char* file, int value)
{
	File onAtFile = LittleFS.open(file, "w");
	if (onAtFile)
	{
		onAtFile.print((String)value);
		onAtFile.close();
	}
}

// Function to handle the root page
void handleSetup()
{
	webServer.send(200, "text/html", htmlPage);
}


void DogServer::handleStatus()
{
	String s = statusPage;
	s.replace("{0}", (String)getTempreture());
	s.replace("{1}", (String)getOnAt());
	s.replace("{2}", (String)getOffAt());
	if (getCurrentlyOn())
	{
		s.replace("{3}", "<span class=\"badge text-bg-danger\">On</span>");
	}
	else
	{
		s.replace("{3}", "<span class=\"badge text-bg-light\">Off</span>");
	}

	webServer.send(200, "text/html", s);
}

void DogServer::handleEditGet()
{
	String s = editPage;
	s.replace("{0}", (String)getOnAt());
	s.replace("{1}", (String)getOffAt());

	webServer.send(200, "text/html", s);
}

void DogServer::handleEditPost()
{
	String onAt = webServer.arg("onAt");
	String offAt = webServer.arg("offAt");

	Serial.print("On At: ");
	Serial.println(onAt);
	Serial.print("Off At: ");
	Serial.println(offAt);

	int value = onAt.toInt();
	if(value != 0)
	{
		this->onAt = value;
		saveIntToFile(ONAT_FILE, value);
	}

	value = offAt.toInt();
	if(value != 0)
	{
		this->offAt = value;
		saveIntToFile(OFFAT_FILE, value);
	}

    webServer.sendHeader("Location", "/");
	webServer.send(302, "text/plain", "");

}

// Function to handle the form submission
void handleSave()
{
	// Retrieve submitted form data
	String newSSID = webServer.arg("ssid");
	String newPassword = webServer.arg("password");

	File wifi = LittleFS.open(WIFIFILE, "w");
	if (wifi)
	{
		wifi.print(newSSID);
		wifi.print('\n');
		wifi.print(newPassword);
		wifi.close();
		webServer.send(200, "text/plain", "Wi-Fi credentials saved. Rebooting...");
	}
	else
	{
		webServer.send(400, "text/plain", "Unable to save redentials");
	}

	// Simulate a reboot (restart the ESP8266)
	delay(2000);
	ESP.restart();
}

int getIntFromFile(const char* file, int defaultValue)
{
	File onAtFile = LittleFS.open(file, "r");
	if (!onAtFile)
	{
		onAtFile = LittleFS.open(file, "w");
		if(onAtFile)
		{
			onAtFile.print((String)defaultValue);
			onAtFile.close();
		}

		return defaultValue;
	}
	else
	{
		String buffer = onAtFile.readString();
		int value = buffer.toInt(); 
		onAtFile.close();
		return value;
	}
}


void DogServer::init()
{

	onAt = getIntFromFile(ONAT_FILE, 70);
	offAt = getIntFromFile(OFFAT_FILE, 75);

	File wf = LittleFS.open(WIFIFILE, "r");

	if (wf)
	{
		String fssid = wf.readStringUntil('\n');
		String fpassword = wf.readString();
		wf.close();

		WiFi.begin(fssid, fpassword);

		// Wait for connection
		Serial.println("Waiting for wifi to connect");
		while (WiFi.status() != WL_CONNECTED)
		{
			delay(1000);
			Serial.print(".");
		}
		Serial.println();
		Serial.println("Wifi Connected");

		Serial.print("IP Address: ");
		Serial.println(WiFi.localIP());

		webServer.on("/", std::bind(&DogServer::handleStatus, this));
		webServer.on("/edit", HTTPMethod::HTTP_GET, std::bind(&DogServer::handleEditGet, this));
		webServer.on("/edit", HTTPMethod::HTTP_POST, std::bind(&DogServer::handleEditPost, this));
	}
	else
	{
		WiFi.softAP(ssid, password);

		webServer.on("/", handleSetup); // Serve the configuration page
		webServer.on("/save", handleSave);
		Serial.println(WiFi.softAPIP());
	}

	// Start the server
	webServer.begin();
}

void DogServer::handleClient()
{
	webServer.handleClient();
}

bool DogServer::getCurrentlyOn()
{
	return this->currentlyOn;
}

void DogServer::setCurrentlyOn(bool isOn)
{
	this->currentlyOn = isOn;
}

int DogServer::getOnAt()
{
	return this->onAt;
}

int DogServer::getOffAt()
{
	return this->offAt;
}

void DogServer::setTempreture(float temp)
{
	this->tempreture = temp;
}

float DogServer::getTempreture()
{
	return this->tempreture;
}
