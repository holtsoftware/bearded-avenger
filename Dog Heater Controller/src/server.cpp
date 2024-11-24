#include <ESP8266WiFi.h>
#include <ESP8266WebServer.h>
#include <functional>
#include "server.h"
#include <SPI.h>
#include "SdFat.h"
#include "sdios.h"
#include <ESP8266HTTPClient.h>
#include <WiFiClient.h>

#define STARTADDRESS 3
#define WIFIFILE "/wifi.cfg"

#define ONAT_FILE "/onAt.cfg"
#define OFFAT_FILE "/offAt.cfg"

// Network credentials
const char *ssid = "DogHouse";		 // Name of the configuration network
const char *password = "@Password1"; // Password for the configuration network

ESP8266WebServer webServer(80);

// SD chip select pin
const uint8_t chipSelect = D8;

// file system object
SdFat sd;

// Constants
const unsigned long SECONDS_IN_A_MINUTE = 60;
const unsigned long SECONDS_IN_AN_HOUR = 3600;	  // 60 * 60
const unsigned long SECONDS_IN_A_DAY = 86400;	  // 24 * 60 * 60
const unsigned long SECONDS_IN_A_YEAR = 31536000; // 365 * SECONDS_IN_A_DAY
const unsigned long MILLIS_IN_A_SECOND = 1000;

// Month lengths (non-leap year)
const int DAYS_IN_MONTHS[] = {31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31};

// Leap year calculation
bool isLeapYear(int year)
{
	return (year % 4 == 0 && year % 100 != 0) || (year % 400 == 0);
}
// Variables to store the offset
unsigned long secondsSince2024 = 0; // Server-provided seconds
unsigned long localMillis = 0;		// millis() at the moment of sync
unsigned long timeOffset = 0;

// Function to calculate the current time
void getCurrentTime(int &year, int &month, int &day, int &hour, int &minute, int &second)
{
	unsigned long totalSeconds = secondsSince2024 + ((millis() - localMillis)/1000);

	// Calculate the year
	year = 2024; // Base year
	while (true)
	{
		unsigned long secondsInYear = SECONDS_IN_A_YEAR + (isLeapYear(year) ? SECONDS_IN_A_DAY : 0);
		if (totalSeconds < secondsInYear)
			break;
		totalSeconds -= secondsInYear;
		year++;
	}

	// Calculate the month and day
	month = 0;
	while (true)
	{
		int daysInMonth = DAYS_IN_MONTHS[month];
		if (month == 1 && isLeapYear(year))
			daysInMonth++; // Adjust for February in leap years
		if (totalSeconds < daysInMonth * SECONDS_IN_A_DAY)
			break;
		totalSeconds -= daysInMonth * SECONDS_IN_A_DAY;
		month++;
	}
	month++; // Convert 0-based index to 1-based
	day = totalSeconds / SECONDS_IN_A_DAY + 1;
	totalSeconds %= SECONDS_IN_A_DAY;

	// Calculate the hour, minute, and second
	hour = totalSeconds / SECONDS_IN_AN_HOUR;
	totalSeconds %= SECONDS_IN_AN_HOUR;
	minute = totalSeconds / SECONDS_IN_A_MINUTE;
	second = totalSeconds % SECONDS_IN_A_MINUTE;
}


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

void saveIntToFile(const char *file, int value)
{
	auto w = sd.open(file, O_WRONLY | O_CREAT | O_TRUNC);
	w.print((String)value);
	w.close();
}

// Function to handle the root page
void handleSetup()
{
	webServer.send(200, "text/html", htmlPage);
}

void DogServer::sendBinaryFile(const String &filename, const String &contentType)
{
	if (sd.exists(filename))
	{
		auto file = sd.open(filename, O_RDONLY);

		webServer.streamFile(file, contentType);
		file.close();
	}
	else
	{
		webServer.send(404, "text/plain", "Not Found");
	}
}

void DogServer::sendFile(const String &filename,const  String &contentType)
{
	if (sd.exists(filename))
	{
		webServer.setContentLength(CONTENT_LENGTH_UNKNOWN);
		webServer.send(200, contentType, "");

		auto file = sd.open(filename, O_RDONLY);
		String line;

		while(file.available())
		{
			line = file.readStringUntil('\n');

			webServer.sendContent(line);
			delay(10);
		}

		file.close();
		webServer.sendContent("");
	}
	else
	{
		webServer.send(404, "text/plain", "Not Found");
	}
}

void DogServer::sendFile(const String &filename,const  String &contentType, std::function<String(const String&)> callback)
{
	if (sd.exists(filename))
	{
		webServer.setContentLength(CONTENT_LENGTH_UNKNOWN);
		webServer.send(200, contentType, "");

		auto file = sd.open(filename, O_RDONLY);
		String line;
		String key;
		String org;
		String value;
		int start;
		int end;

		while(file.available())
		{
			line = file.readStringUntil('\n');
			start = line.indexOf("${");

			while (start > -1)
			{
				end = line.indexOf('}');

				if(end > -1)
				{
					key = line.substring(start + 2, end);

					value = callback(key);

					org = "${";
					org += key;
					org += "}";

					line.replace(org, value);

					start = line.indexOf("${", end);
				}
				else
				{
					start = -1;
				}
			}

			webServer.sendContent(line);
			delay(10);
		}

		file.close();
		webServer.sendContent("");
	}
	else
	{
		webServer.send(404, "text/plain", "Not Found");
	}
}

void DogServer::handleStatus()
{
	this->sendFile("/server/index.htm", "text/html",
	[this](const String& key) -> String
	{
		if (key == "badge")
		{
			if (this->getCurrentlyOn())
			{
				return "<span class=\"badge text-bg-danger\">On</span>";
			}
			else
			{
				return "<span class=\"badge text-bg-light\">Off</span>";
			}
		}
		else if(key == "onAt")
		{
			return (String)this->getOnAt();
		}
		else if(key == "offAt")
		{
			return (String)this->getOffAt();
		}
		else if(key == "temp")
		{
			return (String)this->getTempreture();
		}
		return "";
	});
}

void DogServer::handleEditGet()
{
	this->sendFile("/server/edit.htm", "text/html",
	[this](const String& key) -> String
	{
		if (key == "onAt")
		{
			return (String)this->getOnAt();
		}
		else if(key == "offAt")
		{
			return (String)this->getOffAt();
		}

		return "";
	});
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
	if (value != 0)
	{
		this->onAt = value;
		saveIntToFile(ONAT_FILE, value);
	}

	value = offAt.toInt();
	if (value != 0)
	{
		this->offAt = value;
		saveIntToFile(OFFAT_FILE, value);
	}

	webServer.sendHeader("Location", "/");
	webServer.send(302, "text/plain", "");
}

void DogServer::sendFilesArray(const String &root, const String &currentDir, bool firstSent)
{
	Serial.println(root);
	String rootFile = currentDir + "/" + root;
	if(sd.exists(rootFile))
	{
		auto dir = sd.open(rootFile, O_READ);
		File32 file;
		String fileName;
		while(file.openNext(&dir, O_READ))
		{
			if(file.isSubDir() || file.isDir() || file.isDirectory())
			{
				char name[20];
				file.getName(name, sizeof(name));

				fileName = name;
				Serial.print("Directory: ");
				Serial.println(fileName);
				sendFilesArray(fileName, rootFile, firstSent);
			}
			else
			{
				char name[20];
				file.getName(name, sizeof(name));

				fileName = name;

				Serial.println(fileName);

				if (fileName.endsWith(".csv"))
				{
					String tmp = rootFile;
					tmp.replace("server/","");
					if(firstSent)
					{
						webServer.sendContent(",");
					}
					else
					{
						firstSent = true;
					}
					webServer.sendContent("\"" + tmp + "/" + fileName + "\"");
					delay(10);
				}
			}
			file.close();
		}
		dir.close();
	}
}

void DogServer::handleLogJson()
{
	webServer.setContentLength(CONTENT_LENGTH_UNKNOWN);
	webServer.send(200, "application/json", "");

	webServer.sendContent("[");

	sendFilesArray("logs", "server", false);

	delay(10);
	webServer.sendContent("]");
	webServer.sendContent("");
}

void DogServer::handleAnyFile()
{
	String url = webServer.uri();



	if(url.endsWith(".js"))
	{
		sendBinaryFile("/server" + url, "application/javascript");
	}
	else if(url.endsWith(".json"))
	{
		sendBinaryFile("/server" + url, "application/json");
	}
	else if(url.endsWith(".htm"))
	{
		sendBinaryFile("/server" + url, "text/html");
	}
	else if(url.endsWith(".csv"))
	{
		sendBinaryFile("/server" + url, "text/csv");
	}
	else if(url.endsWith(".css"))
	{
		sendBinaryFile("/server" + url, "text/css");
	}
	else if(url.endsWith(".png"))
	{
		sendBinaryFile("/server" + url, "image/png");
	}
	else if(url.endsWith(".gif"))
	{
		sendBinaryFile("/server" + url, "image/gif");
	}
	else if(url.endsWith(".jpg"))
	{
		sendBinaryFile("/server" + url, "image/jpeg");
	}
	else if(url.endsWith(".xml"))
	{
		sendBinaryFile("/server" + url, "text/xml");
	}
}

// Function to handle the form submission
void handleSave()
{
	// Retrieve submitted form data
	String newSSID = webServer.arg("ssid");
	String newPassword = webServer.arg("password");

	auto wifi = sd.open(WIFIFILE, O_WRONLY | O_CREAT | O_TRUNC);

	wifi.close();
	webServer.send(200, "text/plain", "Wi-Fi credentials saved. Rebooting...");
	// Simulate a reboot (restart the ESP8266)
	delay(2000);
	ESP.restart();
}

int getIntFromFile(const char *file, int defaultValue)
{
	if (!sd.exists(file))
	{
		auto out = sd.open(file, O_WRONLY | O_CREAT | O_TRUNC);
		out.print((String)defaultValue);
		out.close();
		return defaultValue;
	}
	else
	{
		auto in = sd.open(file, O_RDONLY);
		auto buffer = in.readString();
		int value = buffer.toInt();
		in.close();
		return value;
	}
}

void DogServer::init()
{
	// Initialize at the highest speed supported by the board that is
	// not over 50 MHz. Try a lower speed if SPI errors occur.
	if (!sd.begin(chipSelect, SD_SCK_MHZ(20)))
	{
		Serial.println("Failed to init sd card");
		delay(5000);
		sd.initErrorHalt();
	}

	onAt = getIntFromFile(ONAT_FILE, 70);
	offAt = getIntFromFile(OFFAT_FILE, 75);

	if (sd.exists(WIFIFILE))
	{
		// create or open a file for append
		File32 wf = sd.open(WIFIFILE, O_RDONLY);
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
		webServer.on("/logs.json", HTTPMethod::HTTP_GET, std::bind(&DogServer::handleLogJson, this));
		webServer.onNotFound(std::bind(&DogServer::handleAnyFile, this));
		WiFiClient client;
		HTTPClient http;
		http.begin(client, "http://dns.adamholt.us:4321/");
		int httpCode = http.GET();

		if (httpCode > 0)
		{
			String payload = http.getString();
			Serial.print("Server response: ");
			Serial.println(payload);

			// Convert payload to an unsigned long (seconds since 2024)
			secondsSince2024 = payload.toInt();
			localMillis = millis(); // Capture current millis() at sync

			// Calculate the time offset
			timeOffset = secondsSince2024 - (millis() / 1000);
			Serial.print("Time offset (seconds): ");
			Serial.println(timeOffset);
		}

		http.end();
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
	this->logTempreture(temp);
}

float DogServer::getTempreture()
{
	return this->tempreture;
}

void DogServer::logTempreture(float temp)
{
	// Variables to store the extracted time
	int year, month, day, hour, minute, second;

	// Get the current time
	getCurrentTime(year, month, day, hour, minute, second);

	// Print the results
	Serial.printf("%04d-%02d-%02d %02d:%02d:%02d", year, month, day, hour, minute, second);
	Serial.println();

	String s("/server/logs/");
	s += year;
	s += "/";
	s += month;
	sd.mkdir(s);

	s += "/";
	s += day;
	s += ".csv";

	auto exists = sd.exists(s);

	auto file = sd.open(s, O_WRONLY | O_CREAT | O_APPEND);

	if (!exists)
	{
		file.println("Time,Temp");
	}

	file.printf("%04d-%02d-%02d %02d:%02d:%02d", year, month, day, hour, minute, second);
	file.print(",");
	file.println((String)temp);

	file.close();
}
