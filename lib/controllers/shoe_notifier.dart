import 'package:flutter/material.dart';
import 'package:online_shop/models/shoe_model.dart';
import 'package:online_shop/shared/core/helpers/helper.dart';

class ShoeNotifier extends ChangeNotifier {
  List<ShoeModel> maleList = [];
  List<ShoeModel> femaleList = [];
  List<ShoeModel> kidList = [];

  getMaleList() async {
    maleList = await Helper.getMaleShoes();
    notifyListeners();
  }

  getFemaleList() async {
    femaleList = await Helper.getFeMaleShoes();
    notifyListeners();
  }

  getKidList() async {
    kidList = await Helper.getKidShoes();
    notifyListeners();
  }
}
