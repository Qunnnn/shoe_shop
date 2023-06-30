import 'dart:convert';

List<SneakerModel> shoeModelFromJson(String str) => List<SneakerModel>.from(
    json.decode(str).map((x) => SneakerModel.fromJson(x)));

class SneakerModel {
  String id;
  String name;
  String category;
  List<String> imageUrl;
  String oldPrice;
  List<dynamic> sizes;
  List<dynamic>? isSelectedSize;
  String price;
  String description;
  String title;

  SneakerModel({
    required this.id,
    required this.name,
    required this.category,
    required this.imageUrl,
    required this.oldPrice,
    required this.sizes,
    required this.price,
    required this.description,
    required this.title,
    required this.isSelectedSize,
  });

  factory SneakerModel.fromJson(Map<String, dynamic> json) => SneakerModel(
        id: json["id"],
        name: json["name"],
        category: json["category"],
        imageUrl: List<String>.from(json["imageUrl"].map((x) => x)),
        oldPrice: json["oldPrice"],
        sizes: List<dynamic>.from(json["sizes"].map((x) => x)),
        price: json["price"],
        description: json["description"],
        title: json["title"],
        isSelectedSize: json["selectedSizes"],
      );
}
