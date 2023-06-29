import 'dart:convert';

List<SneakerModel> shoeModelFromJson(String str) => List<SneakerModel>.from(json.decode(str).map((x) => SneakerModel.fromJson(x)));

class SneakerModel {
    String id;
    String name;
    String category;
    List<String> imageUrl;
    String oldPrice;
    List<Size> sizes;
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
    });

    factory SneakerModel.fromJson(Map<String, dynamic> json) => SneakerModel(
        id: json["id"],
        name: json["name"],
        category: json["category"],
        imageUrl: List<String>.from(json["imageUrl"].map((x) => x)),
        oldPrice: json["oldPrice"],
        sizes: List<Size>.from(json["sizes"].map((x) => Size.fromJson(x))),
        price: json["price"],
        description: json["description"],
        title: json["title"],
    );


}

class Size {
    String size;
    bool isSelected;

    Size({
        required this.size,
        required this.isSelected,
    });

    factory Size.fromJson(Map<String, dynamic> json) => Size(
        size: json["size"],
        isSelected: json["isSelected"],
    );


}
