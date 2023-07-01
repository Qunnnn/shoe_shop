import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../shared/preferences/preferences.dart';

class CartNotifier extends ChangeNotifier {
  final cartBox = Hive.box(Constants.cartBoxName);
  List<dynamic> _cart = [];

  set cart(List<dynamic> newCart) {
    _cart = newCart;
    notifyListeners();
  }

  List<dynamic> get cart => _cart;

  Future<void> createCart(int key, Map<String, dynamic> value) async {
    await cartBox.put(key, value);
  }

  getCart() {
    final cartData = cartBox.keys.map(
      (key) {
        final item = cartBox.get(key);
        return {
          'id': item['id'],
          'category': item['category'],
          'imageUrl': item['imageUrl'],
          'name': item['name'],
          'qty': item['qty'],
          'price': item['price'],
          'sizes': item['sizes'],
        };
      },
    ).toList();
    _cart = cartData.reversed.toList();
    notifyListeners();
  }

  deleteCart(int id) {
    cartBox.delete(id);
  }
}
