import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import '../view_model/view_model.dart';
import '../shared/component/reusable_top_image.dart';
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
    return Scaffold(
      backgroundColor: AppColors.backGrColor,
      body: Stack(
        children: [
          const ReusableTopImage(),
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: Dimens.dp16, vertical: Dimens.dp10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: Dimens.dp10,
                  ),
                  Text(
                    'My Favorite',
                    style: CustomTextStyle.headerStyle_30_white,
                  ),
                  Builder(builder: (context) {
                    final data = context.watch<FavNotifier>();
                    return SizedBox(
                      height: Dimens.getHeight(context: context) * 0.7,
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
                                  padding: const EdgeInsets.only(
                                      bottom: Dimens.dp10),
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: Dimens.dp10,
                                        horizontal: Dimens.dp20),
                                    height: Dimens.getHeight(context: context) *
                                        0.12,
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
                                        const SizedBox(
                                          width: Dimens.dp16,
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
                                                const SizedBox(
                                                  width: Dimens.dp10,
                                                ),
                                                Row(
                                                  children: [
                                                    Text(
                                                      'sizes',
                                                      style: CustomTextStyle
                                                          .titleStyle_17_black,
                                                    ),
                                                    const SizedBox(
                                                      width: Dimens.dp10,
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
                                            data.deleteCart(
                                                int.parse(sneaker['id']));
                                            data.getFav();
                                            data.getFavIds();
                                          },
                                          child: const Icon(FontAwesomeIcons
                                              .heartCircleXmark),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                    );
                  })
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
