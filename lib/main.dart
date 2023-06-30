import 'package:flutter/material.dart';
import 'package:online_shop/controllers/main_screen_notifier.dart';
import 'package:online_shop/controllers/sneaker_notifier.dart';
import 'package:online_shop/shared/core/local_storage/hive.dart';
import 'package:online_shop/views/main_screen.dart';
import 'package:provider/provider.dart';

void main() async {
  HiveStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => MainScreenNotifier()),
        ChangeNotifierProvider(create: (context) => SneakerNotifier()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Qun',
        theme: ThemeData(
          useMaterial3: true,
        ),
        home: MainScreen(),
      ),
    );
  }
}
