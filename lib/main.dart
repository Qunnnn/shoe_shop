import 'package:flutter/material.dart';
import 'package:online_shop/controllers/main_screen_notifier.dart';
import 'package:online_shop/controllers/shoe_notifier.dart';
import 'package:online_shop/views/main_screen.dart';
import 'package:provider/provider.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => MainScreenNotifier()), 
        ChangeNotifierProvider(create: (context) => ShoeNotifier()), 
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
