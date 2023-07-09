import 'package:flutter/material.dart';
import 'package:online_shop/view_model/main_screen_notifier.dart';
import 'package:online_shop/views/views.dart';
import 'package:provider/provider.dart';
import '../shared/component/component.dart';
import '../shared/preferences/preferences.dart';

// ignore: must_be_immutable
class MainScreen extends StatelessWidget {
  MainScreen({super.key});

  List<Widget> screenList = [
    const HomeScreen(),
    const SearchScreen(),
    const FavScreen(),
    const CartScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backGrColor,
      body: Builder(
        builder: (context) {
          final mainScreenNotifier = context.watch<MainScreenNotifier>();
          return screenList[mainScreenNotifier.pageIndex];
        },
      ),
      bottomNavigationBar: const BottomNav(),
    );
  }
}
