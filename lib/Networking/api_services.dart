import 'dart:convert';
import 'package:http/http.dart' as http;

import '../Models/dog_breed_image_model.dart';
import '../Models/dog_breed_model.dart';

class Networking {
  final String baseUrl = 'https://dog.ceo/api';

  Future<DogBreeds> fetchDogBreeds() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/breeds/list/all'));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        return DogBreeds.fromJson(data);
      } else {
        throw Exception('Failed to load dog breeds. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<DogImage> fetchImagesByBreed(String breedName) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/breed/$breedName/images/random/1'));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        return DogImage.fromJson(data);
      } else {
        throw Exception('Failed to load images for breed $breedName. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
