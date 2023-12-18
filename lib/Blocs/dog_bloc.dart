import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dog_breed_app/Models/dog_breed_image_model.dart';
import 'package:dog_breed_app/Models/dog_breed_model.dart';
import 'package:dog_breed_app/Networking/api_services.dart';

// Events
abstract class DogBreedEvent {}

class FetchDogBreedsEvent extends DogBreedEvent {}

class FilterDogBreedsEvent extends DogBreedEvent {
  final String query;

  FilterDogBreedsEvent(this.query);
}

// States
abstract class DogBreedState {}

class DogBreedInitialState extends DogBreedState {}

class DogBreedLoadedState extends DogBreedState {
  final List<String> dogImageUrls;
  final Map<String, List<String>> breedMap;

  DogBreedLoadedState(this.dogImageUrls, this.breedMap);
}

class DogBreedFilteredState extends DogBreedState {
  final List<String> dogImageUrls;
  final Map<String, List<String>> breedMap;

  DogBreedFilteredState(this.dogImageUrls, this.breedMap);
}

class DogBreedErrorState extends DogBreedState {
  final String errorMessage;

  DogBreedErrorState(this.errorMessage);
}

// Bloc
class DogBreedBloc extends Bloc<DogBreedEvent, DogBreedState> {
  final Networking networking = Networking();
  late List<String> allDogImageUrls;
  late List<String> displayedDogImageUrls;
  late DogBreeds dogBreedsMap;
  late DogBreeds allDogBreedsMap;

  DogBreedBloc() : super(DogBreedInitialState()) {
    on<FetchDogBreedsEvent>(_mapFetchDogBreedsToState);
    on<FilterDogBreedsEvent>(_mapFilterDogBreedsToState);
  }

  void _mapFetchDogBreedsToState(FetchDogBreedsEvent event, Emitter<DogBreedState> emit) async {
    try {
      final DogBreeds dogBreeds = await networking.fetchDogBreeds();
      final List<Future<DogImage>> imageFutures = [];

      for (var entry in dogBreeds.breedMap.keys) {
        final breedName = entry;
        final Future<DogImage> imageFuture = _fetchAndCacheImage(breedName);
        imageFutures.add(imageFuture);
      }

      final List<DogImage> dogImages = await Future.wait(imageFutures);
      final List<String> dogImageUrls = dogImages.map((image) => image.imageUrl).toList();

      allDogImageUrls = List.from(dogImageUrls);
      displayedDogImageUrls = List.from(dogImageUrls);
      dogBreedsMap = dogBreeds;
      allDogBreedsMap = dogBreeds;

      if (kDebugMode) {
        print('DogBreedLoadedState emitted');
      }
      emit(DogBreedLoadedState(dogImageUrls, dogBreeds.breedMap));
    } catch (e) {
      if (e is Exception) {
        if (kDebugMode) {
          print('DogBreedErrorState emitted with error: $e');
        }
        emit(DogBreedErrorState('Error: ${e.toString()}'));
      } else {
        if (kDebugMode) {
          print('DogBreedErrorState emitted with unexpected error');
        }
        emit(DogBreedErrorState('Unexpected Error'));
      }
    }
  }

  Future<DogImage> _fetchAndCacheImage(String breedName) async {
    try {
      final DogImage dogImage = await networking.fetchImagesByBreed(breedName);
      return dogImage;
    } catch (e) {
      throw Exception('Error fetching image for breed $breedName: $e');
    }
  }

  void _mapFilterDogBreedsToState(FilterDogBreedsEvent event, Emitter<DogBreedState> emit) {
    try {
      final String query = event.query.toLowerCase();

      // Filter the URLs directly
      displayedDogImageUrls = allDogImageUrls.where((url) => url.toLowerCase().contains(query)).toList();

      // Filter the breeds map based on the query
      final Map<String, List<String>> filteredBreedsMap = {};
      dogBreedsMap.breedMap.keys.where((breed) => breed.toLowerCase().contains(query)).forEach((breed) {
        filteredBreedsMap[breed] = dogBreedsMap.breedMap[breed]!;
      });

      if (displayedDogImageUrls.isEmpty) {
        emit(DogBreedErrorState('No results found'));
      } else {
        emit(DogBreedFilteredState(displayedDogImageUrls, filteredBreedsMap));
      }
    } catch (e) {
      if (e is Exception) {
        if (kDebugMode) {
          print('DogBreedErrorState emitted with error: $e');
        }
        emit(DogBreedErrorState(e.toString()));
      } else {
        if (kDebugMode) {
          print('DogBreedErrorState emitted with unexpected error');
        }
        emit(DogBreedErrorState('Unexpected Error'));
      }
    }
  }

}