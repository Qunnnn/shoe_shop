import 'package:flutter/material.dart';
import 'package:online_shop/controllers/main_screen_notifier.dart';
import 'package:online_shop/views/views.dart';
import 'package:provider/provider.dart';
import '../shared/component/component.dart';
import '../shared/preferences/preferences.dart';

// ignore: must_be_immutable
class MainScreen extends StatelessWidget {
  MainScreen({super.key});

  List<Widget> screenList = [
    const HomeScreen(),
    const CartScreen(),
    const AddScreen(),
    const SearchScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final mainScreenNotifier = context.watch<MainScreenNotifier>();
    return Scaffold(
      backgroundColor: AppColors.backGrColor,
      body: screenList[mainScreenNotifier.pageIndex],
      bottomNavigationBar: const BottomNav(),
    );
  }
}
