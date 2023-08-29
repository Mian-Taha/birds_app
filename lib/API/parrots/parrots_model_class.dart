class Parrot {
  final int id;
  final String category;
  final String name;
  final double price;
  final String imageUrl; // Add this field for the image URL

  Parrot({
    required this.id,
    required this.category,
    required this.name,
    required this.price,
    required this.imageUrl,
  });

  factory Parrot.fromJson(Map<String, dynamic> json) {
    return Parrot(
      id: json['id'],
      name: json['name'],
      category: json['category'],
      price: json['price'].toDouble(),
      imageUrl: json['image'],
    );
  }
}
