import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../Providers/weather_provider.dart';
import '../../../Providers/detailed_weather_provider.dart'; // Search par 7-days data update karne ke liye

class Dashboard_Screen extends StatefulWidget {
  const Dashboard_Screen({super.key});

  @override
  State<Dashboard_Screen> createState() => _Dashboard_ScreenState();
}

class _Dashboard_ScreenState extends State<Dashboard_Screen> {

  // Dynamic City Search Function
  void _searchCity(String cityName) {
    if (cityName.trim().isNotEmpty) {
      // Update both current weather and 7-day forecast
      context.read<WeatherProvider>().fetchWeatherByCity(cityName.trim());
      context.read<DetailedWeatherProvider>().fetchDetailedWeather(cityName.trim());
    }
  }

  @override
  Widget build(BuildContext context) {
    final weatherProvider = context.watch<WeatherProvider>();

    // Get Firebase Current User
    final User? currentUser = FirebaseAuth.instance.currentUser;
    final String userName = currentUser?.displayName ?? 'User';
    final String userEmail = currentUser?.email ?? '';

    return Scaffold(
      backgroundColor: const Color(0xff02150E),
      body: weatherProvider.isLoading
          ? const Center(
        child: CircularProgressIndicator(color: Color(0xff25D366)),
      )
          : Column(
        children: [
          Flexible(
            flex: 7,
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Color(0xff25D366),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(80),
                  bottomRight: Radius.circular(80),
                ),
              ),
              child: SafeArea(
                // Added SingleChildScrollView to prevent pixel overflow
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      // 1. User Header & Settings Row
                      Padding(
                        padding: const EdgeInsets.only(top: 10, left: 20, right: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Hi, $userName 👋',
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                if (userEmail.isNotEmpty)
                                  Text(
                                    userEmail,
                                    style: const TextStyle(
                                      color: Colors.black87,
                                      fontSize: 12,
                                    ),
                                  ),
                              ],
                            ),
                            IconButton(
                              icon: const Icon(
                                Icons.settings_outlined,
                                color: Colors.white,
                                size: 30,
                              ),
                              onPressed: () =>
                                  Navigator.pushNamed(context, '/profile'),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                        child: TextField(
                          style: const TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            hintText: 'Search city...',
                            hintStyle: const TextStyle(color: Colors.white54),
                            prefixIcon: const Icon(Icons.search, color: Colors.white70),
                            filled: true,
                            fillColor: const Color(0xff041E12).withOpacity(0.5),
                            contentPadding: const EdgeInsets.symmetric(vertical: 0),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide.none,
                            ),
                          ),
                          onSubmitted: _searchCity, // Triggers API call on enter
                        ),
                      ),

                      // 3. Current Weather UI
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.location_on,
                              color: Colors.white, size: 20),
                          const SizedBox(width: 4),
                          Text(
                            weatherProvider.cityName,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Image.asset(
                          'Assets/Raining_cloud.png',
                          width: 140, // Reduced slightly to fit search bar
                          height: 140,
                        ),
                      ),
                      Text(
                        '${weatherProvider.temperature}°',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 60,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      Text(
                        weatherProvider.weatherDescription,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20, bottom: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            _buildWeatherDetail(
                              Icons.air_outlined,
                              '${weatherProvider.windSpeed}km/h',
                              'wind',
                            ),
                            _buildWeatherDetail(
                              Icons.water_drop_outlined,
                              '${weatherProvider.humidity}%',
                              'humidity',
                            ),
                            _buildWeatherDetail(
                              Icons.grain,
                              '80%',
                              'rain chance',
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // Bottom Hourly & 7-Day Forecast Navigation Section
          Flexible(
            flex: 3,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Today',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white70,
                        ),
                      ),
                      GestureDetector(
                        onTap: () =>
                            Navigator.pushNamed(context, '/detailed'),
                        child: const Text(
                          '7 Days >',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white70,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildHourlyCard('31°', '12:00'),
                      _buildHourlyCard('32°', '01:00'),
                      _buildHourlyCard('33°', '02:00'),
                      _buildHourlyCard('34°', '03:00'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWeatherDetail(IconData icon, String value, String label) {
    return Column(
      children: [
        Icon(icon, color: Colors.white, size: 24),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          label,
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 14,
          ),
        ),
      ],
    );
  }

  Widget _buildHourlyCard(String temp, String time) {
    return Container(
      height: 125,
      width: 80,
      decoration: BoxDecoration(
        color: const Color(0xff041E12),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            temp,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 18,
              fontWeight: FontWeight.w300,
            ),
          ),
          Image.asset(
            'Assets/raining_cloud_green.png',
            height: 40,
            width: 40,
            errorBuilder: (_, __, ___) => const Icon(
              Icons.cloudy_snowing,
              color: Color(0xff25D366),
              size: 32,
            ),
          ),
          Text(
            time,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 14,
              fontWeight: FontWeight.w300,
            ),
          ),
        ],
      ),
    );
  }
}