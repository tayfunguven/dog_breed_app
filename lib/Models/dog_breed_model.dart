class DogBreeds {
  Map<String, List<String>> breedMap;
  String status;

  DogBreeds({required this.breedMap, required this.status});

  factory DogBreeds.fromJson(Map<String, dynamic> json) {

    final Map<String, List<String>> breedMap = {};
    json['message'].forEach((key, value) {
      if (value is List) {
        breedMap[key] = List<String>.from(value);
      } else {
        breedMap[key] = [];
      }
    });

    return DogBreeds(
      breedMap: breedMap,
      status: json['status'],
    );
  }
}
