import 'package:dog_breed_app/Blocs/dog_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dogBreedBloc = BlocProvider.of<DogBreedBloc>(context);

    void onApiCallComplete() {
      Navigator.pushReplacementNamed(context, '/home');
    }
    dogBreedBloc.add(FetchDogBreedsEvent());

    return BlocListener<DogBreedBloc, DogBreedState>(
      listener: (context, state) {
        if (state is DogBreedLoadedState) {
          onApiCallComplete();
        } else if (state is DogBreedErrorState) {
          if (kDebugMode) {
            print('Error: ${state.errorMessage}');
          }
        }
      },
      child: const Scaffold(
        body: SafeArea(
          child: Center(
            child: Image(
              width: 64,
              height: 64,
              image: AssetImage('assets/logo.png'),
            ),
          ),
        ),
      ),
    );
  }
}
