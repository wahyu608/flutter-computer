class Product {
  String id;
  String title;
  String description;
  String image;
  String harga;

  Product(
      {required this.id,
      required this.title,
      required this.description,
      required this.image,
      required this.harga});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      image: json['image'],
      harga: json['harga'],
    );
  }
}
