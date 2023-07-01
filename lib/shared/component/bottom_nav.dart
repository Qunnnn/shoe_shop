import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:online_shop/shared/component/component.dart';
import 'package:provider/provider.dart';
import '../../controllers/main_screen_notifier.dart';
import '../preferences/preferences.dart';

class BottomNav extends StatelessWidget {
  const BottomNav({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final mainScreenNotifier = Provider.of<MainScreenNotifier>(context);
    return Container(
      margin: EdgeInsets.only(
          bottom: Dimens.dhp15, left: Dimens.dwp10, right: Dimens.dwp10),
      height: Dimens.getHeight(height: 60),
      decoration: BoxDecoration(
        color: AppColors.bottomNavColor,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          BottomNavIcon(
              icon: FontAwesomeIcons.house,
              clr: mainScreenNotifier.pageIndex == 0
                  ? AppColors.activeIconClr
                  : AppColors.inActiveIconClr,
              onTap: () {
                mainScreenNotifier.pageIndex = 0;
              }),
          BottomNavIcon(
              icon: FontAwesomeIcons.magnifyingGlass,
              clr: mainScreenNotifier.pageIndex == 1
                  ? AppColors.activeIconClr
                  : AppColors.inActiveIconClr,
              onTap: () {
                mainScreenNotifier.pageIndex = 1;
              }),
          BottomNavIcon(
              icon: FontAwesomeIcons.heart,
              clr: mainScreenNotifier.pageIndex == 2
                  ? AppColors.activeIconClr
                  : AppColors.inActiveIconClr,
              onTap: () {
                mainScreenNotifier.pageIndex = 2;
              }),
          BottomNavIcon(
              icon: FontAwesomeIcons.cartShopping,
              clr: mainScreenNotifier.pageIndex == 3
                  ? AppColors.activeIconClr
                  : AppColors.inActiveIconClr,
              onTap: () {
                mainScreenNotifier.pageIndex = 3;
              }),
          BottomNavIcon(
              icon: FontAwesomeIcons.user,
              clr: mainScreenNotifier.pageIndex == 4
                  ? AppColors.activeIconClr
                  : AppColors.inActiveIconClr,
              onTap: () {
                mainScreenNotifier.pageIndex = 4;
              }),
        ],
      ),
    );
  }
}
