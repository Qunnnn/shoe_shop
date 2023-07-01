import 'package:flutter/material.dart';

import '../preferences/preferences.dart';

class TabBarWidget extends StatelessWidget {
  const TabBarWidget({
    super.key,
    required TabController tabController,
  }) : _tabController = tabController;

  final TabController _tabController;

  @override
  Widget build(BuildContext context) {
    return TabBar(
        padding: EdgeInsets.only(top: Dimens.dhp10),
        controller: _tabController,
        indicatorColor: Colors.transparent,
        labelStyle: CustomTextStyle.titleStyle_17_grey,
        labelColor: Colors.white,
        dividerColor: Colors.transparent,
        isScrollable: true,
        tabs: const [
          Text(
            'Men Shoes',
          ),
          Text(
            'Women Shoes',
          ),
          Text(
            'Kid Shoes',
          ),
        ]);
  }
}
