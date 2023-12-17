import 'package:dog_breed_app/Screens/home_screen.dart';
import 'package:dog_breed_app/Screens/splash_screen.dart';
import 'package:flutter/material.dart';

void main() async {
    runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/': (context) => const SplashScreen(),
        '/home': (context) => const HomeScreen()
      },
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'GalanoGrotesque'),
    );
  }
}
