import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:dog_breed_app/Models/dog_breed_image_model.dart';
import 'package:dog_breed_app/Models/dog_breed_model.dart';
import 'package:dog_breed_app/Networking/api_services.dart';

class DogEvent {}

class DogState {
  final DogBreeds? dogBreeds;
  final List<DogImage> dogImages;

  DogState({this.dogBreeds, this.dogImages = const []});
}

class DogBloc extends Bloc<DogEvent, DogState> {
  final Networking _networking = Networking();

  DogBloc() : super(DogState());

  Stream<DogState> mapEventToState(DogEvent event) async* {
    if (event is FetchDogData) {
      try {
        final DogBreeds dogBreeds = await _networking.fetchDogBreeds();
        final List<Future<DogImage>> imageFutures = [];

        for (var entry in dogBreeds.breedMap.keys) {
          final breedName = entry;
          imageFutures.add(_networking.fetchImagesByBreed(breedName));
        }

        final List<DogImage> dogImages = await Future.wait(imageFutures);

        yield DogState(dogBreeds: dogBreeds, dogImages: dogImages);
      } catch (e) {
        yield DogState(); // Handle error state as needed
      }
    }
  }
}



class FetchDogData extends DogEvent {}
