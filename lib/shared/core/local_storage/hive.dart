import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:online_shop/shared/preferences/preferences.dart';

class HiveStorage {
  static init() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Hive.initFlutter();
    await Hive.openBox(Constants.cartBoxName);
    await Hive.openBox(Constants.favBoxName);
  }
}
