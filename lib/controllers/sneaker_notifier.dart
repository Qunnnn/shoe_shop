import 'package:flutter/material.dart';
import 'package:online_shop/models/sneaker_model.dart';
import 'package:online_shop/shared/core/helpers/helper.dart';

class SneakerNotifier extends ChangeNotifier {
  List<SneakerModel> maleList = [];
  List<SneakerModel> femaleList = [];
  List<SneakerModel> kidList = [];
  List<dynamic> sizes = [];
  List<dynamic> get sneakerSizes => sizes;
  SneakerModel? sneaker;

  set sneakerSizes(List<dynamic> newSizes) {
    sizes = newSizes;
    notifyListeners();
  }

  clearSize() {
    sizes = [];
    notifyListeners();
  }

  toggleSizeCheck(int index) {
    for (int i = 0; i < sizes.length; i++) {
      if (i == index) {
        sizes[i]['isSelected'] = !sizes[i]['isSelected'];
        notifyListeners();
      }
    }
  }

  getMaleList() async {
    maleList = await Helper.getMaleSneakers();
    notifyListeners();
  }

  getFemaleList() async {
    femaleList = await Helper.getFeMaleSneakers();
    notifyListeners();
  }

  getKidList() async {
    kidList = await Helper.getKidSneakers();
    notifyListeners();
  }

  getMaleSnekerByid({required String id}) async {
    sneaker = await Helper.getMaleSneakerById(id);
    notifyListeners();
  }

  getFemaleSnekerByid({required String id}) async {
    sneaker = await Helper.getFemaleSneakerById(id);
    notifyListeners();
  }

  getKidSnekerByid({required String id}) async {
    sneaker = await Helper.getkidSneakerById(id);
    notifyListeners();
  }
}
