import 'dart:convert';

List<ShoeModel> shoeModelFromJson(String str) => List<ShoeModel>.from(json.decode(str).map((x) => ShoeModel.fromJson(x)));

class ShoeModel {
    String id;
    String name;
    String category;
    List<String> imageUrl;
    String oldPrice;
    List<Size> sizes;
    String price;
    String description;
    String title;

    ShoeModel({
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

    factory ShoeModel.fromJson(Map<String, dynamic> json) => ShoeModel(
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
