import 'package:dog_breed_app/Utils/custom_bnavbar.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Dog Breeds", style: TextStyle(fontWeight: FontWeight.bold),),
      ),
      extendBody: true,
      extendBodyBehindAppBar: false,
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 15.0,
          crossAxisSpacing: 15.0,
        ),
        padding: const EdgeInsets.all(15.0),
        itemCount: 18,
        itemBuilder: (context, index) {
          return Container(
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(10.0), // Adjust the value as needed
            ),
            child: Center(
              child: Text(
                index.toString(),
                style: const TextStyle(fontSize: 18.0, color: Colors.white),
              ),
            ),
          )
          ;
        },
      ),
      bottomNavigationBar: const CustomBottomNavBar(),
    );
  }
}
