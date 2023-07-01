import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import '../controllers/controllers.dart';
import '../shared/preferences/preferences.dart';

class FavScreen extends StatefulWidget {
  const FavScreen({super.key});

  @override
  State<FavScreen> createState() => _FavScreenState();
}

class _FavScreenState extends State<FavScreen> {
  late FavNotifier favNotifier;
  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      favNotifier = Provider.of<FavNotifier>(context, listen: false);
      favNotifier.getFav();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final data = context.watch<FavNotifier>();
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
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: Dimens.dwp15, vertical: Dimens.dhp10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: Dimens.dhp20,
                  ),
                  Text(
                    'My Favorite',
                    style: CustomTextStyle.headerStyle_30_white,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.7,
                    child: data.favorite.isEmpty
                        ? Center(
                            child: Text(
                              'You have not add to your favorites yet!',
                              style: CustomTextStyle.titleStyle_17_black,
                            ),
                          )
                        : ListView.builder(
                            itemCount: data.favorite.length,
                            itemBuilder: (context, index) {
                              final sneaker = data.favorite[index];
                              return Padding(
                                padding: EdgeInsets.only(bottom: Dimens.dhp10),
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: Dimens.dhp5,
                                      horizontal: Dimens.dwp10),
                                  height: Dimens.getHeight(height: 80),
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: Colors.white,
                                  ),
                                  child: Row(
                                    children: [
                                      CachedNetworkImage(
                                        imageUrl: sneaker['imageUrl'],
                                        fit: BoxFit.fill,
                                      ),
                                      SizedBox(
                                        width: Dimens.dwp15,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            sneaker['name'],
                                            style: CustomTextStyle
                                                .headerStyle_16_black,
                                          ),
                                          Text(
                                            sneaker['category'],
                                            style: CustomTextStyle
                                                .titleStyle_15_grey,
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                '\$${sneaker['price']}',
                                                style: CustomTextStyle
                                                    .titleStyle_17_black,
                                              ),
                                              SizedBox(
                                                width: Dimens.dwp10,
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                    'sizes',
                                                    style: CustomTextStyle
                                                        .titleStyle_17_black,
                                                  ),
                                                  SizedBox(
                                                    width: Dimens.dwp10,
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      const Spacer(),
                                      GestureDetector(
                                        onTap: () {
                                          data.deleteCart(int.parse(sneaker['id']));
                                          data.getFav();
                                          data.getFavIds();
                                        },
                                        child: const Icon(
                                            FontAwesomeIcons.heartCircleXmark),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
