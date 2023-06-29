import 'package:flutter/services.dart';
import 'package:online_shop/models/sneaker_model.dart';
import 'package:online_shop/shared/preferences/preferences.dart';

class Helper {
  static Future<List<SneakerModel>> getMaleSneakers() async {
    final data = await rootBundle.loadString(AssetPath.maleShoe);
    final maleList = shoeModelFromJson(data);
    return maleList;
  }

  static Future<List<SneakerModel>> getFeMaleSneakers() async {
    final data = await rootBundle.loadString(AssetPath.femaleShoe);
    final femaleList = shoeModelFromJson(data);
    return femaleList;
  }

  static Future<List<SneakerModel>> getKidSneakers() async {
    final data = await rootBundle.loadString(AssetPath.kidShoe);
    final kidList = shoeModelFromJson(data);
    return kidList;
  }

  static Future<SneakerModel> getMaleSneakerById(String id) async {
    final data = await rootBundle.loadString(AssetPath.maleShoe);
    final maleList = shoeModelFromJson(data);
    final sneaker = maleList.firstWhere((sneaker) => sneaker.id == id );
    return sneaker;
  }
    static Future<SneakerModel> getFemaleSneakerById(String id) async {
    final data = await rootBundle.loadString(AssetPath.femaleShoe);
    final femaleList = shoeModelFromJson(data);
    final sneaker = femaleList.firstWhere((sneaker) => sneaker.id == id );
    return sneaker;
  }
    static Future<SneakerModel> getkidSneakerById(String id) async {
    final data = await rootBundle.loadString(AssetPath.kidShoe);
    final kidList = shoeModelFromJson(data);
    final sneaker = kidList.firstWhere((sneaker) => sneaker.id == id );
    return sneaker;
  }
}
