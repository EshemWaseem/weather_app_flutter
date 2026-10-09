import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import '../Services/remote_config_service.dart';

class WeatherProvider extends ChangeNotifier {
  final RemoteConfigService _configService;

  WeatherProvider(this._configService) {
    fetchWeatherForCurrentLocation();
  }

  bool _isLoading = true;
  String? _errorMessage;

  String _cityName = "Loading Location...";
  double _temperature = 0.0;
  String _weatherDescription = "Loading...";
  double _windSpeed = 0.0;
  int _humidity = 0;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  String get cityName => _cityName;
  int get temperature => _temperature.round();
  String get weatherDescription => _weatherDescription;
  int get windSpeed => _windSpeed.round();
  int get humidity => _humidity;

  Future<void> fetchWeatherForCurrentLocation() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        throw Exception('Location services are disabled.');
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          throw Exception('Location permission was denied.');
        }
      }

      if (permission == LocationPermission.deniedForever) {
        throw Exception('Location permission is permanently denied.');
      }

      final Position position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(accuracy: LocationAccuracy.high),
      );

      await _fetchWeather(position.latitude, position.longitude);
    } catch (e) {
      _cityName = "Lahore";
      await fetchWeatherByCity("Lahore");
    }
  }

  Future<void> _fetchWeather(double latitude, double longitude) async {
    try {
      final String apiKey = await _configService.getOpenWeatherApiKey();
      final Uri url = Uri.https('api.openweathermap.org', '/data/2.5/weather', {
        'lat': latitude.toString(),
        'lon': longitude.toString(),
        'appid': apiKey,
        'units': 'metric',
      });

      final http.Response response = await http.get(url);

      if (response.statusCode != 200) {
        throw Exception('Weather API failed: ${response.statusCode}');
      }

      final Map<String, dynamic> data = jsonDecode(response.body);

      _cityName = '${data['name']}, ${data['sys']['country']}';
      _temperature = (data['main']['temp'] as num).toDouble();
      _humidity = (data['main']['humidity'] as num).toInt();
      _weatherDescription = data['weather'][0]['main'] as String;
      _windSpeed = ((data['wind']['speed'] as num) * 3.6).toDouble();
      _errorMessage = null;
    } catch (e) {
      _errorMessage = 'Could not fetch weather data.';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchWeatherByCity(String city) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final String apiKey = await _configService.getOpenWeatherApiKey();
      final Uri url = Uri.https('api.openweathermap.org', '/data/2.5/weather', {
        'q': city.trim(),
        'appid': apiKey,
        'units': 'metric',
      });

      final http.Response response = await http.get(url);

      if (response.statusCode != 200) {
        _errorMessage = 'Could not find weather for $city.';
        return;
      }

      final Map<String, dynamic> data = jsonDecode(response.body);

      _cityName = '${data['name']}, ${data['sys']['country']}';
      _temperature = (data['main']['temp'] as num).toDouble();
      _humidity = (data['main']['humidity'] as num).toInt();
      _weatherDescription = data['weather'][0]['main'] as String;
      _windSpeed = ((data['wind']['speed'] as num) * 3.6).toDouble();
      _errorMessage = null;
    } catch (e) {
      _errorMessage = 'Something went wrong while fetching weather.';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}