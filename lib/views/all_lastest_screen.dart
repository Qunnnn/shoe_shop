import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import '../controllers/sneaker_notifier.dart';
import '../shared/component/component.dart';
import '../shared/preferences/preferences.dart';

class AllLastestScreen extends StatefulWidget {
  AllLastestScreen({super.key, required this.tabIndex});
  int tabIndex;
  @override
  State<AllLastestScreen> createState() => _AllLastestScreenState();
}

class _AllLastestScreenState extends State<AllLastestScreen>
    with TickerProviderStateMixin {
  late final TabController _tabController;
  @override
  void initState() {
    _tabController =
        TabController(length: 3, vsync: this, initialIndex: widget.tabIndex);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final sneakers = context.read<SneakerNotifier>();
    return Scaffold(
      backgroundColor: AppColors.backGrColor, 
      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.symmetric(
                horizontal: Dimens.dwp20, vertical: Dimens.dhp25),
            height: Dimens.getHeight(height: 250),
            width: double.infinity,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(AssetPath.topImage), fit: BoxFit.fill)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: Dimens.dhp10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        FontAwesomeIcons.xmark,
                        color: Colors.white,
                        size: Dimens.getHeight(height: 25),
                      ),
                    ),
                    Icon(
                      FontAwesomeIcons.filter,
                      color: Colors.white,
                      size: Dimens.getHeight(height: 25),
                    ),
                  ],
                ),
                SizedBox(
                  height: Dimens.dhp10,
                ),
                TabBarWidget(tabController: _tabController),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                top: Dimens.getHeight(height: 100),
                left: Dimens.dwp10,
                right: Dimens.dwp10,
                bottom: Dimens.dhp20),
            child: TabBarView(controller: _tabController, children: [
              AnimationLimiter(
                child: AllLastestShoeWidget(
                  sneakers: sneakers.maleList,
                ),
              ),
              AllLastestShoeWidget(
                sneakers: sneakers.femaleList,
              ),
              AllLastestShoeWidget(
                sneakers: sneakers.kidList,
              ),
            ]),
          ),
        ],
      ),
    );
  }
}
