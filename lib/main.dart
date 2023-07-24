import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:online_shop/view_model/view_model.dart';
import 'package:online_shop/shared/preferences/constant.dart';
import 'package:online_shop/views/main_screen.dart';
import 'package:provider/provider.dart';

void main() async {
  timeDilation = 3.0;
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox(Constants.cartBoxName);
  await Hive.openBox(Constants.favBoxName);
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
        ChangeNotifierProvider(create: (context) => CartNotifier()),
        ChangeNotifierProvider(
          create: (context) => FavNotifier(),
        )
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
