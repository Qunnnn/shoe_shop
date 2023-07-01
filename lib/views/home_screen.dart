import 'package:flutter/material.dart';
import 'package:online_shop/controllers/sneaker_notifier.dart';
import 'package:online_shop/shared/preferences/preferences.dart';
import 'package:provider/provider.dart';
import '../shared/component/component.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late final TabController _tabController;
  late final SneakerNotifier shoeNotifier;
  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    shoeNotifier = Provider.of<SneakerNotifier>(context, listen: false);
    shoeNotifier.getMaleList();
    shoeNotifier.getFemaleList();
    shoeNotifier.getKidList();
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final sneakers = context.watch<SneakerNotifier>();
    return Scaffold(
      backgroundColor: AppColors.backGrColor,
      body: Stack(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
                horizontal: Dimens.dp20, vertical: Dimens.dp26),
            height: Dimens.getHeight(context: context, height: 250),
            width: double.infinity,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(AssetPath.topImage), fit: BoxFit.fill)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Athletics Shoes',
                  style: CustomTextStyle.headerStyle_30_white,
                ),
                Text(
                  'Collection',
                  style: CustomTextStyle.headerStyle_30_white,
                ),
                TabBarWidget(tabController: _tabController),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                top: Dimens.getHeight(context: context, height: 180),
                left: Dimens.dp20),
            child: TabBarView(controller: _tabController, children: [
              HomeWidget(sneakers: sneakers.maleList, tabIndex: 0),
              HomeWidget(sneakers: sneakers.femaleList, tabIndex: 1),
              HomeWidget(sneakers: sneakers.kidList, tabIndex: 2),
            ]),
          ),
        ],
      ),
    );
  }
}
