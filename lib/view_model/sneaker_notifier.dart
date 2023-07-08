import 'package:flutter/material.dart';
import 'package:online_shop/models/sneaker_model.dart';
import 'package:online_shop/shared/core/helpers/helper.dart';

class SneakerNotifier extends ChangeNotifier {
  List<SneakerModel> _maleList = [];
  List<SneakerModel> _femaleList = [];
  List<SneakerModel> _kidList = [];
  List<dynamic> _sneakerSizes = [];
  SneakerModel? _sneaker;

  set sneakerSizes(List<dynamic> newSizes) {
    _sneakerSizes = newSizes;
    notifyListeners();
  }

  List<dynamic> get sneakerSizes => _sneakerSizes;

  set sneaker(SneakerModel? value) {
    _sneaker = value;
  }

  SneakerModel? get sneaker => _sneaker;

  set maleList(List<SneakerModel> data) {
    _maleList = data;
  }

  List<SneakerModel> get maleList => _maleList;

  set femaleList(List<SneakerModel> data) {
    _femaleList = data;
  }

  List<SneakerModel> get femaleList => _femaleList;

  set kidList(List<SneakerModel> data) {
    _kidList = data;
  }

  List<SneakerModel> get kidList => _kidList;

  toggleSizeCheck(int index) {
    for (int i = 0; i < _sneakerSizes.length; i++) {
      if (i == index) {
        _sneakerSizes[i]['isSelected'] = !_sneakerSizes[i]['isSelected'];
        notifyListeners();
      }
    }
  }

  getMaleList() async {
    _maleList = await Helper.getMaleSneakers();
     notifyListeners();
  }

  getFemaleList() async {
    _femaleList = await Helper.getFeMaleSneakers();
     notifyListeners();
  }

  getKidList() async {
    _kidList = await Helper.getKidSneakers();
     notifyListeners();
  }

  getMaleSnekerByid({required String id}) async {
    _sneaker = await Helper.getMaleSneakerById(id);
     notifyListeners();
  }

  getFemaleSnekerByid({required String id}) async {
    _sneaker = await Helper.getFemaleSneakerById(id);
     notifyListeners();
  }

  getKidSnekerByid({required String id}) async {
    _sneaker = await Helper.getkidSneakerById(id);
     notifyListeners();
  }
}
