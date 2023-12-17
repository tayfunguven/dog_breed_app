import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dog_breed_app/Models/dog_breed_image_model.dart';
import 'package:dog_breed_app/Models/dog_breed_model.dart';
import 'package:dog_breed_app/Networking/api_services.dart';

// Events
abstract class DogBreedEvent {}

class FetchDogBreedsEvent extends DogBreedEvent {}

// States
abstract class DogBreedState {}

class DogBreedInitialState extends DogBreedState {}

class DogBreedLoadedState extends DogBreedState {
  final List<DogImage> dogImages;

  DogBreedLoadedState(this.dogImages);
}

class DogBreedErrorState extends DogBreedState {
  final String errorMessage;

  DogBreedErrorState(this.errorMessage);
}

// Bloc
class DogBreedBloc extends Bloc<DogBreedEvent, DogBreedState> {
  final Networking networking = Networking();

  DogBreedBloc() : super(DogBreedInitialState()) {
    on<FetchDogBreedsEvent>(_mapFetchDogBreedsToState);
  }

  void _mapFetchDogBreedsToState(FetchDogBreedsEvent event, Emitter<DogBreedState> emit) async {
    try {
      final DogBreeds dogBreeds = await networking.fetchDogBreeds();
      final List<Future<DogImage>> imageFutures = [];

      for (var entry in dogBreeds.breedMap.keys) {
        final breedName = entry;
        imageFutures.add(networking.fetchImagesByBreed(breedName));
      }

      final List<DogImage> dogImages = await Future.wait(imageFutures);
      print('DogBreedLoadedState emitted');
      emit(DogBreedLoadedState(dogImages));
    } catch (e) {
      // Handle different types of errors and provide more details in the error state
      if (e is Exception) {
        print('DogBreedErrorState emitted with error: $e');
        emit(DogBreedErrorState('Error: ${e.toString()}'));
      } else {
        print('DogBreedErrorState emitted with unexpected error');
        emit(DogBreedErrorState('Unexpected Error'));
      }
    }
  }


}



