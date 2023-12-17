import 'dart:async';
import 'package:flutter/material.dart';
import 'package:dog_breed_app/Models/dog_breed_image_model.dart';
import 'package:dog_breed_app/Models/dog_breed_model.dart';
import 'package:dog_breed_app/Networking/api_services.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future getDogBreedData() async {
    final Networking networking = Networking();

    try {
      // Step 1: Fetch dog breeds
      final DogBreeds dogBreeds = await networking.fetchDogBreeds();

      // Step 2: Create a list of futures for fetching images
      final List<Future<DogImage>> imageFutures = [];

      for (var entry in dogBreeds.breedMap.keys) {
        final breedName = entry;
        imageFutures.add(networking.fetchImagesByBreed(breedName));
      }

      // Step 3: Execute all image fetch futures concurrently
      final List<DogImage> dogImages = await Future.wait(imageFutures);

      // Step 4: Use the fetched images as needed
      for (int i = 0; i < dogImages.length; i++) {
        final breedName = dogBreeds.breedMap.keys.elementAt(i);
        final DogImage dogImage = dogImages[i];

        // Use breedName and dogImage.imageUrl as needed
        print('$breedName image URL: ${dogImage.imageUrl}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }
  @override
  void initState() {
    super.initState();
    getDogBreedData();
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, '/home');
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Center(
          child: Image(
            width: 64,
            height: 64,
            image: AssetImage('assets/logo.png'),
          ),
        ),
      ),
    );
  }
}
