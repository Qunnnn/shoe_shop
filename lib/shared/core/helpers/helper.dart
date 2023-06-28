import 'package:flutter/services.dart' ;
import 'package:online_shop/models/shoe_model.dart';
import 'package:online_shop/shared/preferences/preferences.dart';

class Helper {
 static Future<List<ShoeModel>> getMaleShoes() async {
    final data = await rootBundle.loadString(AssetPath.maleShoe);
    final maleList = shoeModelFromJson(data);
    return maleList;
  }
 static Future<List<ShoeModel>> getFeMaleShoes() async {
    final data = await rootBundle.loadString(AssetPath.femaleShoe);
    final femaleList = shoeModelFromJson(data);
    return femaleList;
  }
  static  Future<List<ShoeModel>> getKidShoes() async {
    final data = await rootBundle.loadString(AssetPath.kidShoe);
    final kidList = shoeModelFromJson(data);
    return kidList;
  }
}
