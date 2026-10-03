import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../Services/remote_config_service.dart';

class DailyForecast {
  final String day;
  final String condition;
  final int temp;
  final String icon;

  DailyForecast({
    required this.day,
    required this.condition,
    required this.temp,
    required this.icon,
  });
}

class DetailedWeatherProvider extends ChangeNotifier {
  final RemoteConfigService _configService;

  bool _isLoading = false;
  String? _errorMessage;

  int _temperature = 0;
  int _windSpeed = 0;
  int _humidity = 0;
  String _date = "";
  String _condition = "";
  String _location = "";
  String _iconCode = "10d";

  List<DailyForecast> _forecastList = [];

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  int get temperature => _temperature;
  int get windSpeed => _windSpeed;
  int get humidity => _humidity;
  String get date => _date;
  String get condition => _condition;
  String get location => _location;
  String get iconCode => _iconCode;
  List<DailyForecast> get forecastList => _forecastList;

  DetailedWeatherProvider(this._configService) {
    fetchDetailedWeather("Lahore");
  }

  Future<void> fetchDetailedWeather(String city) async {
    if (city.trim().isEmpty || city == "Unknown Location" || city == "Loading Location...") return;

    _isLoading = true;
    _errorMessage = null;

    Future.microtask(() => notifyListeners());

    try {
      final apiKey = await _configService.getOpenWeatherApiKey();
      final url = Uri.parse(
          'https://api.openweathermap.org/data/2.5/forecast?q=${city.trim()}&appid=$apiKey&units=metric');

      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        _location = "${data['city']['name']}, ${data['city']['country']}";

        final List<dynamic> list = data['list'];
        if (list.isNotEmpty) {
          final current = list[0];
          _temperature = (current['main']['temp'] as num).round();
          _humidity = (current['main']['humidity'] as num).toInt();
          _windSpeed = ((current['wind']['speed'] as num) * 3.6).round();
          _condition = current['weather'][0]['main'];
          _iconCode = current['weather'][0]['icon'] ?? '10d';

          final dt = DateTime.fromMillisecondsSinceEpoch((current['dt'] as int) * 1000);
          final months = [
            'January', 'February', 'March', 'April', 'May', 'June',
            'July', 'August', 'September', 'October', 'November', 'December'
          ];
          _date = "${dt.day}, ${months[dt.month - 1]}";

          final weekdays = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];
          final Map<String, DailyForecast> uniqueDays = {};

          for (var item in list) {
            final forecastDate = DateTime.fromMillisecondsSinceEpoch((item['dt'] as int) * 1000);
            final dayKey = weekdays[forecastDate.weekday - 1];

            if (!uniqueDays.containsKey(dayKey) || item['dt_txt'].toString().contains("12:00:00")) {
              uniqueDays[dayKey] = DailyForecast(
                day: dayKey,
                condition: item['weather'][0]['main'],
                temp: (item['main']['temp'] as num).round(),
                icon: item['weather'][0]['icon'] ?? '10d',
              );
            }
          }

          _forecastList = uniqueDays.values.toList();
        }
      } else {
        _errorMessage = "City not found or API error.";
      }
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}