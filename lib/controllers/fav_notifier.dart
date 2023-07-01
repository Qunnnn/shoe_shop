import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../shared/preferences/constant.dart';

class FavNotifier extends ChangeNotifier {
  List<dynamic> _fav = [];
  List<dynamic> _ids = [];
  final favBox = Hive.box(Constants.favBoxName);

  set favorite(List<dynamic> newFav) {
    _fav = newFav;
  }

  List<dynamic> get favorite => _fav;

  set ids(List<dynamic> newId) {
    _ids = newId;
  }

  List<dynamic> get ids => _ids;

  Future<void> createFav(int key, Map<String, dynamic> value) async {
    await favBox.put(key, value);
  }

  getFavIds() {
    final favIds = favBox.keys.map((key) {
      final item = favBox.get(key);
      return {
        'id': item['id'],
      };
    }).toList();
    _ids = favIds.map((e) => e['id']).toList();
    notifyListeners();
  }

  getFav() {
    final favData = favBox.keys.map(
      (key) {
        final item = favBox.get(key);
        return {
          'id': item['id'],
          'category': item['category'],
          'imageUrl': item['imageUrl'],
          'name': item['name'],
          'price': item['price'],
        };
      },
    ).toList();
    _fav = favData.reversed.toList();
    notifyListeners();
  }

  deleteCart(int key) {
    favBox.delete(key);
  }
}
