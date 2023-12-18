import 'package:cached_network_image/cached_network_image.dart';
import 'package:dog_breed_app/Blocs/dog_bloc.dart';
import 'package:dog_breed_app/Networking/api_services.dart';
import 'package:dog_breed_app/Utils/custom_bnavbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final Networking networking = Networking();
  String capitalize(String input) {
    return input.isNotEmpty ? input[0].toUpperCase() + input.substring(1) : input;
  }

  @override
  Widget build(BuildContext context) {
    final TextEditingController searchController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Dog Breeds", style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      extendBody: true,
      extendBodyBehindAppBar: false,
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<DogBreedBloc, DogBreedState>(
              builder: (context, state) {
                if (state is DogBreedInitialState) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is DogBreedLoadedState || state is DogBreedFilteredState) {
                  final dogImageUrls = (state as dynamic).dogImageUrls as List<String>;
                  final breedMap = (state as dynamic).breedMap as Map<String, List<String>>;
                  return Padding(
                      padding: const EdgeInsets.only(bottom: 80.0),
                      child: GridView.builder(
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 15.0,
                          crossAxisSpacing: 15.0,
                        ),
                        padding: const EdgeInsets.all(15.0),
                        itemCount: dogImageUrls.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () => showDialog<String>(
                              context: context,
                              builder: (BuildContext context) => Dialog(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    ClipRRect(
                                      borderRadius: const BorderRadius.only(topLeft: Radius.circular(12), topRight: Radius.circular(12)),
                                      child: Stack(
                                        children: [
                                          CachedNetworkImage(
                                            imageUrl: dogImageUrls[index],
                                            width: double.infinity,
                                            height: 343,
                                            fit: BoxFit.cover,
                                            placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                                            errorWidget: (context, url, error) => const Icon(Icons.error),
                                          ),
                                          Positioned(
                                            top: 10,
                                            right: 10,
                                            child: Container(
                                              height: 30,
                                              width: 30,
                                              decoration: const BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Colors.white,
                                              ),
                                              child: IconButton(
                                                icon: const Icon(Icons.close, size: 16),
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 10,),
                                    const Text("Breed", style: TextStyle(color: CupertinoColors.systemBlue, fontSize: 20, fontWeight: FontWeight.bold),),
                                    const Divider(indent: 30, endIndent: 30,),
                                    Text(
                                      capitalize(breedMap.keys.elementAt(index).toString()),
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                    const Text("Sub Breed", style: TextStyle(color: CupertinoColors.systemBlue, fontSize: 20, fontWeight: FontWeight.bold),),
                                    const Divider(indent: 30, endIndent: 30,),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: breedMap.values.elementAt(index).map((subBreed) {
                                        final subBreedIndex = breedMap.values.elementAt(index).indexOf(subBreed);
                                        if (subBreedIndex >= 0 && subBreedIndex < dogImageUrls.length) {
                                          return Text(
                                            capitalize(subBreed.toString()),
                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          );
                                        } else {
                                          return Container();
                                        }
                                      }).toList(),
                                    ),

                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 8.0, top: 8.0, left: 8, right: 8),
                                      child: SizedBox(
                                        width: 312,
                                        height: 56,
                                        child: ElevatedButton(
                                          style: ButtonStyle(
                                            backgroundColor: MaterialStateProperty.all<Color>(
                                              CupertinoColors.systemBlue,
                                            ),
                                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                              RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(8.0),
                                                side: const BorderSide(color: Colors.transparent),
                                              ),
                                            ),
                                          ),
                                          onPressed: () {
                                            final currentContext = context;
                                            final randomImage = dogImageUrls[index];

                                            showDialog<String>(
                                              context: currentContext,
                                              builder: (context) => Dialog(
                                                backgroundColor: Colors.transparent,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(12.0),
                                                ),
                                                child: Column(
                                                  mainAxisSize: MainAxisSize.min,
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: <Widget>[
                                                    ClipRRect(
                                                      borderRadius: const BorderRadius.all(Radius.circular(12)),
                                                      child: CachedNetworkImage(
                                                        imageUrl: randomImage.toString(),
                                                        width: 250,
                                                        height: 250,
                                                        fit: BoxFit.cover,
                                                        placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                                                        errorWidget: (context, url, error) => const Icon(Icons.error),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets.only(bottom: 8.0, top: 8.0, left: 8, right: 8),
                                                      child: SizedBox(
                                                        width: 312,
                                                        height: 56,
                                                        child: IconButton(
                                                          onPressed: () {
                                                            Navigator.pop(context);
                                                          },
                                                          icon: Container(
                                                            width: 30,
                                                            height: 30,
                                                            decoration: const BoxDecoration(
                                                              shape: BoxShape.rectangle,
                                                              color: Colors.white,
                                                            ),
                                                            child: const Icon(
                                                              Icons.close,
                                                              color: Colors.black,
                                                              size: 20,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            );
                                          },
                                          child: const Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Text(
                                              'Generate',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 16,
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            child: ClipRRect(
                              borderRadius: const BorderRadius.all(Radius.circular(8)),
                              child: Stack(
                                fit: StackFit.expand,
                                children: [
                                  CachedNetworkImage(
                                    imageUrl: dogImageUrls[index],
                                    width: double.infinity,
                                    height: double.infinity,
                                    fit: BoxFit.cover,
                                    placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                                    errorWidget: (context, url, error) => const Icon(Icons.error),
                                  ),
                                  Positioned(
                                    left: 0,
                                    bottom: 0,
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                      decoration: BoxDecoration(
                                        color: Colors.black.withOpacity(0.3),
                                        borderRadius: const BorderRadius.only(
                                          bottomLeft: Radius.circular(8),
                                          topRight: Radius.circular(8),
                                        ),
                                      ),
                                      child: Text(
                                        (index >= 0 && index < breedMap.keys.length)
                                            ? breedMap.keys.elementAt(index).toString()
                                            : '',
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      )
                  );
                } else if (state is DogBreedErrorState) {
                  return Center(child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(state.errorMessage, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
                      const Text("Try searching with another word", style: TextStyle(color: Colors.grey,fontSize: 16),)
                    ],
                  )
                  );
                } else {
                  return const Center(child: Text('Unexpected State'));
                }
              },
            ),
          ),
        ],
      ),
      floatingActionButton: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        width: 378,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey, width: 0.8),
        ),
        child: TextField(
          controller: searchController,
          decoration: const InputDecoration(
            hintText: 'Search by dog name...',
            border: InputBorder.none,
          ),
          onChanged: (query) {
            BlocProvider.of<DogBreedBloc>(context).add(FilterDogBreedsEvent(query));
          },
        ),
      ),
      bottomNavigationBar: const CustomBottomNavBar(),
    );
  }
}