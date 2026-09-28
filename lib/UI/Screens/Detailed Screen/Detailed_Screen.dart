import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../Providers/detailed_weather_provider.dart';

class Detailed_Screen extends StatefulWidget {
  const Detailed_Screen({super.key});

  @override
  State<Detailed_Screen> createState() => _Detailed_ScreenState();
}

class _Detailed_ScreenState extends State<Detailed_Screen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onSearch(String query) {
    if (query.trim().isNotEmpty) {
      context.read<DetailedWeatherProvider>().fetchDetailedWeather(query.trim());
      _searchController.clear();
      FocusScope.of(context).unfocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<DetailedWeatherProvider>();

    return Scaffold(
      backgroundColor: const Color(0xff02150E),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Detailed Forecast',
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              // Search Input for Any City
              Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: TextField(
                  controller: _searchController,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: 'Search city forecast... (e.g. London, Tokyo)',
                    hintStyle: const TextStyle(color: Colors.white38, fontSize: 14),
                    prefixIcon: const Icon(Icons.search, color: Color(0xff25D366)),
                    filled: true,
                    fillColor: const Color(0xff041E12),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                      borderSide: const BorderSide(color: Colors.white24),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                      borderSide: const BorderSide(color: Colors.white24),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                      borderSide: const BorderSide(color: Color(0xff25D366), width: 1.5),
                    ),
                  ),
                  onSubmitted: _onSearch,
                ),
              ),

              if (provider.isLoading)
                const Expanded(
                  child: Center(
                    child: CircularProgressIndicator(color: Color(0xff25D366)),
                  ),
                )
              else if (provider.errorMessage != null)
                Expanded(
                  child: Center(
                    child: Text(
                      provider.errorMessage!,
                      style: const TextStyle(color: Colors.redAccent, fontSize: 16),
                    ),
                  ),
                )
              else ...[
                  // Top Overview Row
                  Row(
                    children: [
                      // Left Bright Green Card
                      Expanded(
                        flex: 5,
                        child: Container(
                          height: 180,
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: const Color(0xff25D366),
                            borderRadius: BorderRadius.circular(24),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '${provider.temperature}°C',
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 38,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      const Icon(Icons.air, color: Colors.black87, size: 18),
                                      const SizedBox(width: 4),
                                      Text(
                                        'Wind ${provider.windSpeed}km/h',
                                        style: const TextStyle(
                                          color: Colors.black87,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 4),
                                  Row(
                                    children: [
                                      const Icon(Icons.water_drop_outlined, color: Colors.black87, size: 18),
                                      const SizedBox(width: 4),
                                      Text(
                                        'Humidity ${provider.humidity}%',
                                        style: const TextStyle(
                                          color: Colors.black87,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Text(
                                provider.date,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 14),

                      // Right 2 Stacked Cards
                      Expanded(
                        flex: 4,
                        child: SizedBox(
                          height: 180,
                          child: Column(
                            children: [
                              // Top Dark Condition Card
                              Expanded(
                                flex: 6,
                                child: Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: const Color(0xff041E12),
                                    borderRadius: BorderRadius.circular(24),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.network(
                                        'https://openweathermap.org/img/wn/${provider.iconCode}@2x.png',
                                        width: 55,
                                        height: 55,
                                        errorBuilder: (_, __, ___) => const Icon(
                                          Icons.cloudy_snowing,
                                          color: Color(0xff25D366),
                                          size: 40,
                                        ),
                                      ),
                                      const SizedBox(height: 6),
                                      Text(
                                        provider.condition,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),

                              // Bottom Light Green Location Card
                              Expanded(
                                flex: 4,
                                child: Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: const Color(0xff25D366),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Icon(Icons.location_on, color: Colors.black, size: 18),
                                      const SizedBox(width: 4),
                                      Flexible(
                                        child: Text(
                                          provider.location,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 13,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // Live Multi-day Forecast List from API
                  Expanded(
                    child: ListView.separated(
                      itemCount: provider.forecastList.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 10),
                      itemBuilder: (context, index) {
                        final item = provider.forecastList[index];
                        return Container(
                          height: 64,
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          decoration: BoxDecoration(
                            color: const Color(0xff041E12),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: 50,
                                child: Text(
                                  item.day,
                                  style: const TextStyle(
                                    color: Colors.white70,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              Row(
                                children: [
                                  Image.network(
                                    'https://openweathermap.org/img/wn/${item.icon}.png',
                                    width: 32,
                                    height: 32,
                                    errorBuilder: (_, __, ___) => const Icon(
                                      Icons.cloudy_snowing,
                                      color: Color(0xff25D366),
                                      size: 24,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    item.condition,
                                    style: const TextStyle(
                                      color: Colors.white70,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                '${item.temp}°C',
                                style: const TextStyle(
                                  color: Colors.white70,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
            ],
          ),
        ),
      ),
    );
  }
}