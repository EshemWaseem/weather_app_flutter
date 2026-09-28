
import 'dart:convert';

import  'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

import '../Services/remote_config_service.dart';

class WeatherProvider extends ChangeNotifier {
final RemoteConfigService _configService;

WeatherProvider(this._configService) {
fetchWeatherForCurrentLocation();
}

// ============================================================
// VARIABLES
// ============================================================

bool _isLoading = true;
String? _errorMessage;

String _cityName = "Loading Location...";
double _temperature = 0.0;
String _weatherDescription = "Loading...";
double _windSpeed = 0.0;
int _humidity = 0;

// ============================================================
// GETTERS
// ============================================================

bool get isLoading => _isLoading;

String? get errorMessage => _errorMessage;

String get cityName => _cityName;

int get temperature => _temperature.round();

String get weatherDescription => _weatherDescription;

int get windSpeed => _windSpeed.round();

int get humidity => _humidity;

// ============================================================
// CURRENT LOCATION
// ============================================================

Future<void> fetchWeatherForCurrentLocation() async {
_isLoading = true;
_errorMessage = null;

notifyListeners();

try {
// ----------------------------------------------------------
// 1. Check if location service is enabled
// ----------------------------------------------------------

final bool serviceEnabled =
await Geolocator.isLocationServiceEnabled();

if (!serviceEnabled) {
throw Exception(
'Location services are disabled.',
);
}

// ----------------------------------------------------------
// 2. Check permission
// ----------------------------------------------------------

LocationPermission permission =
await Geolocator.checkPermission();

// ----------------------------------------------------------
// 3. Request permission
// ----------------------------------------------------------

if (permission == LocationPermission.denied) {
permission = await Geolocator.requestPermission();

if (permission == LocationPermission.denied) {
throw Exception(
'Location permission was denied.',
);
}
}

// ----------------------------------------------------------
// 4. Permanently denied
// ----------------------------------------------------------

if (permission == LocationPermission.deniedForever) {
throw Exception(
'Location permission is permanently denied.',
);
}

// ----------------------------------------------------------
// 5. Get current position
// ----------------------------------------------------------

final Position position =
await Geolocator.getCurrentPosition(
locationSettings: const LocationSettings(
accuracy: LocationAccuracy.high,
),
);

debugPrint(
'Latitude: ${position.latitude}',
);

debugPrint(
'Longitude: ${position.longitude}',
);

// ----------------------------------------------------------
// 6. Get city name
// ----------------------------------------------------------

await _getCityName(
position.latitude,
position.longitude,
);

// ----------------------------------------------------------
// 7. Get weather
// ----------------------------------------------------------

await _fetchWeather(
position.latitude,
position.longitude,
);
} catch (e) {
debugPrint(
'Location Error: $e',
);

// ----------------------------------------------------------
// FALLBACK
// ----------------------------------------------------------

_cityName = "Ferozewala";

await fetchWeatherByCity("Ferozewala");
}
}

// ============================================================
// GET CITY NAME FROM COORDINATES
// ============================================================

Future<void> _getCityName(
double latitude,
double longitude,
) async {
try {
// IMPORTANT:
// geocoding 5.x uses the Geocoding class.

final Geocoding geocoding = Geocoding();

final List<Placemark> placemarks =
await geocoding.placemarkFromCoordinates(
latitude,
longitude,
);

if (placemarks.isNotEmpty) {
final Placemark place = placemarks.first;

_cityName =
place.locality ??
place.subAdministrativeArea ??
place.administrativeArea ??
"Unknown Location";

debugPrint(
'Detected City: $_cityName',
);
}
} catch (e) {
debugPrint(
'Geocoding Error: $e',
);

_cityName = "Unknown Location";
}
}

// ============================================================
// FETCH WEATHER USING LATITUDE + LONGITUDE
// ============================================================

Future<void> _fetchWeather(
double latitude,
double longitude,
) async {
try {
// ----------------------------------------------------------
// 1. Get API key
// ----------------------------------------------------------

final String apiKey =
await _configService.getOpenWeatherApiKey();

// ----------------------------------------------------------
// 2. Build OpenWeather URL
// ----------------------------------------------------------

final Uri url = Uri.https(
'api.openweathermap.org',
'/data/2.5/weather',
{
'lat': latitude.toString(),
'lon': longitude.toString(),
'appid': apiKey,
'units': 'metric',
},
);

// ----------------------------------------------------------
// 3. API request
// ----------------------------------------------------------

final http.Response response =
await http.get(url);

debugPrint(
'Weather API Status: ${response.statusCode}',
);

// ----------------------------------------------------------
// 4. Check response
// ----------------------------------------------------------

if (response.statusCode != 200) {
throw Exception(
'Weather API failed: ${response.statusCode}',
);
}

// ----------------------------------------------------------
// 5. Decode JSON
// ----------------------------------------------------------

final Map<String, dynamic> data =
jsonDecode(response.body);

// ----------------------------------------------------------
// 6. Temperature
// ----------------------------------------------------------

_temperature =
(data['main']['temp'] as num).toDouble();

// ----------------------------------------------------------
// 7. Humidity
// ----------------------------------------------------------

_humidity =
(data['main']['humidity'] as num).toInt();

// ----------------------------------------------------------
// 8. Weather description
// ----------------------------------------------------------

_weatherDescription =
data['weather'][0]['main'] as String;

// ----------------------------------------------------------
// 9. Wind speed
// OpenWeather = meters/second
// Convert to km/hour
// ----------------------------------------------------------

_windSpeed =
((data['wind']['speed'] as num) * 3.6)
    .toDouble();

// ----------------------------------------------------------
// 10. Fallback city name
// ----------------------------------------------------------

if (_cityName == "Unknown Location" ||
_cityName == "Loading Location...") {
final String? apiCity =
data['name'];

if (apiCity != null && apiCity.isNotEmpty) {
_cityName = apiCity;
}
}

_errorMessage = null;

debugPrint(
'Weather loaded successfully.',
);
} catch (e) {
debugPrint(
'Weather API Error: $e',
);

_errorMessage =
'Could not fetch weather data.';
} finally {
_isLoading = false;

notifyListeners();
}
}

// ============================================================
// FETCH WEATHER BY CITY
// ============================================================

Future<void> fetchWeatherByCity(
String city,
) async {
_isLoading = true;
_errorMessage = null;

notifyListeners();

try {
// ----------------------------------------------------------
// 1. Get API key
// ----------------------------------------------------------

final String apiKey =
await _configService.getOpenWeatherApiKey();

// ----------------------------------------------------------
// 2. Build URL
// ----------------------------------------------------------

final Uri url = Uri.https(
'api.openweathermap.org',
'/data/2.5/weather',
{
'q': city.trim(),
'appid': apiKey,
'units': 'metric',
},
);

// ----------------------------------------------------------
// 3. API request
// ----------------------------------------------------------

final http.Response response =
await http.get(url);

// ----------------------------------------------------------
// 4. Check response
// ----------------------------------------------------------

if (response.statusCode != 200) {
_errorMessage =
'Could not find weather for $city.';

return;
}

// ----------------------------------------------------------
// 5. Decode JSON
// ----------------------------------------------------------

final Map<String, dynamic> data =
jsonDecode(response.body);

// ----------------------------------------------------------
// 6. City
// ----------------------------------------------------------

_cityName =
'${data['name']}, ${data['sys']['country']}';

// ----------------------------------------------------------
// 7. Temperature
// ----------------------------------------------------------

_temperature =
(data['main']['temp'] as num).toDouble();

// ----------------------------------------------------------
// 8. Humidity
// ----------------------------------------------------------

_humidity =
(data['main']['humidity'] as num).toInt();

// ----------------------------------------------------------
// 9. Weather
// ----------------------------------------------------------

_weatherDescription =
data['weather'][0]['main'] as String;

// ----------------------------------------------------------
// 10. Wind
// ----------------------------------------------------------

_windSpeed =
((data['wind']['speed'] as num) * 3.6)
    .toDouble();

_errorMessage = null;
} catch (e) {
debugPrint(
'City Weather Error: $e',
);

_errorMessage =
'Something went wrong while fetching weather.';
} finally {
_isLoading = false;

notifyListeners();
}
}
}
