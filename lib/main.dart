import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

import 'Services/remote_config_service.dart';
import 'Providers/signin_provider.dart';
import 'Providers/signup_provider.dart';
import 'Providers/profile_provider.dart';
import 'Providers/weather_provider.dart';
import 'Providers/detailed_weather_provider.dart';
import 'UI/Screens/Dashboard Screen/Dashboard_Screen.dart';
import 'UI/Screens/Detailed Screen/Detailed_Screen.dart';
import 'UI/Screens/Login Screen/Login_Screen.dart';
import 'UI/Screens/Profile Screen/Profile_Screen.dart';
import 'UI/Screens/Signup Screen/Signup_Screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(
    MultiProvider(
      providers: [
        Provider<RemoteConfigService>(
          create: (_) => RemoteConfigService(),
        ),

        // 2. Auth & User Profile Providers
        ChangeNotifierProvider(create: (_) => SigninProvider()),
        ChangeNotifierProvider(create: (_) => SignupProvider()),
        ChangeNotifierProvider(create: (_) => ProfileProvider()),


        ChangeNotifierProxyProvider<RemoteConfigService, WeatherProvider>(
          create: (context) => WeatherProvider(context.read<RemoteConfigService>()),
          update: (context, config, previous) => previous ?? WeatherProvider(config),
        ),
        ChangeNotifierProxyProvider<RemoteConfigService, DetailedWeatherProvider>(
          create: (context) => DetailedWeatherProvider(context.read<RemoteConfigService>()),
          update: (context, config, previous) => previous ?? DetailedWeatherProvider(config),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Weather App',
      initialRoute: '/login',
      routes: {
        '/login': (context) => const Login_Screen(),
        '/signup': (context) => const Signup_Screen(),
        '/dashboard': (context) => const Dashboard_Screen(),
        '/profile': (context) => const Profile_Screen(),
        '/detailed': (context) => const Detailed_Screen(),
      },
    );
  }
}