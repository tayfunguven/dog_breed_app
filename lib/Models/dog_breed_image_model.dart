class DogImage {
  String imageUrl;
  String status;

  DogImage({required this.imageUrl, required this.status});

  factory DogImage.fromJson(Map<String, dynamic> json) {
    return DogImage(
      imageUrl: json['message'][0],
      status: json['status'],
    );
  }
}
