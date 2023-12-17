import 'package:dog_breed_app/Blocs/dog_bloc.dart';
import 'package:dog_breed_app/Utils/custom_bnavbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Dog Breeds", style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      extendBody: true,
      extendBodyBehindAppBar: false,
      body: BlocBuilder<DogBreedBloc, DogBreedState>(
        builder: (context, state) {
          print(state);
          if (state is DogBreedInitialState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is DogBreedLoadedState) {
            // Build your grid with dog images
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 15.0,
                crossAxisSpacing: 15.0,
              ),
              padding: const EdgeInsets.all(15.0),
              itemCount: state.dogImages.length,
              itemBuilder: (context, index) {
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Center(
                    child: Image.network(
                      state.dogImages[index].imageUrl,
                      width: double.infinity,
                      height: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              },
            );
          } else if (state is DogBreedErrorState) {
            // Show error message
            return Center(child: Text('Error: ${state.errorMessage}'));
          } else {
            // Handle other states if needed
            return const Center(child: Text('Unexpected State'));
          }
        },
      ),
      bottomNavigationBar: const CustomBottomNavBar(),
    );
  }
}
