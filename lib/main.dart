import 'package:dog_breed_app/Blocs/dog_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dog_breed_app/Screens/home_screen.dart';
import 'package:dog_breed_app/Screens/splash_screen.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final DogBreedBloc _dogBreedBloc = DogBreedBloc();

  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/': (context) => BlocProvider(
          create: (context) => _dogBreedBloc,
          child: const SplashScreen(),
        ),
        '/home': (context) => BlocProvider.value(
          value: _dogBreedBloc,
          child: const HomeScreen(),
        ),
      },
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'GalanoGrotesque'),
    );
  }
}

