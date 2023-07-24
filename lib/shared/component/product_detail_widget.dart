import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:online_shop/view_model/view_model.dart';
import 'package:online_shop/shared/component/component.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../preferences/preferences.dart';

class ProductDetailWidget extends StatelessWidget {
  const ProductDetailWidget({
    super.key,
    required PageController pageController,
    required this.defaultPadding,
  }) : _pageController = pageController;

  final PageController _pageController;
  final SizedBox defaultPadding;

  @override
  Widget build(BuildContext context) {
    final cartNotifier = context.read<CartNotifier>();
    return Stack(
      children: [
        SizedBox(
          height: Dimens.getHeight(context: context) * 0.3,
          width: double.infinity,
          child: Builder(builder: (context) {
            final sneakerNotifier = context.watch<SneakerNotifier>();
            final sneaker = sneakerNotifier.sneaker!;
            return PageView.builder(
              controller: _pageController,
              itemCount: sneaker.imageUrl.length,
              onPageChanged: (value) {},
              itemBuilder: (context, index) {
                return Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      color: Colors.grey[400],
                      child: Hero(
                          tag: sneaker.id + index.toString(),
                          child: CachedNetworkImage(
                              imageUrl: sneaker.imageUrl[index])),
                    ),
                    Builder(builder: (context) {
                      final favProvider = Provider.of<FavNotifier>(context);
                      return Positioned(
                          top: Dimens.getHeight(context: context) * 0.08,
                          right: Dimens.getWidth(context: context) * 0.04,
                          child: GestureDetector(
                            onTap: () {
                              if (favProvider.ids.contains(sneaker.id)) {
                                favProvider.deleteCart(int.parse(sneaker.id));
                                favProvider.getFavIds();
                                favProvider.getFav();
                              } else {
                                favProvider.createFav(int.parse(sneaker.id), {
                                  'id': sneaker.id,
                                  'category': sneaker.category,
                                  'imageUrl': sneaker.imageUrl[0],
                                  'name': sneaker.name,
                                  'price': sneaker.price,
                                });
                                favProvider.getFavIds();
                                favProvider.getFav();
                              }
                            },
                            child: Icon(
                                favProvider.ids.contains(sneaker.id)
                                    ? FontAwesomeIcons.solidHeart
                                    : FontAwesomeIcons.heart,
                                color: favProvider.ids.contains(sneaker.id)
                                    ? Colors.pink[400]
                                    : Colors.grey),
                          ));
                    }),
                    Padding(
                      padding: const EdgeInsets.only(bottom: Dimens.dp26),
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: SmoothPageIndicator(
                          controller: _pageController,
                          count: sneaker.imageUrl.length,
                          effect: JumpingDotEffect(
                            activeDotColor: Colors.black,
                            dotColor: Colors.grey,
                            dotHeight:
                                Dimens.getHeight(context: context) * 0.01,
                            dotWidth: Dimens.getWidth(context: context) * 0.02,
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            );
          }),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            padding: const EdgeInsets.all(10),
            height: Dimens.getHeight(context: context) * 0.75,
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20)),
            ),
            child: SingleChildScrollView(
              child: Builder(builder: (context) {
                final sneakerNotifier = context.watch<SneakerNotifier>();
                final sneaker = sneakerNotifier.sneaker!;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(sneaker.name,
                        style: CustomTextStyle.headerStyle_28_black),
                    defaultPadding,
                    Row(
                      children: [
                        Text(
                          sneaker.category,
                          style: CustomTextStyle.titleStyle_15_grey,
                        ),
                        const SizedBox(
                          width: Dimens.dp20,
                        ),
                        RatingBar.builder(
                          itemSize: 20,
                          initialRating: 3,
                          minRating: 1,
                          maxRating: 5,
                          unratedColor: Colors.grey,
                          allowHalfRating: true,
                          itemBuilder: (context, index) => const Icon(
                            Icons.star,
                            color: Colors.black,
                            fill: 0.5,
                          ),
                          onRatingUpdate: (value) {},
                        ),
                      ],
                    ),
                    defaultPadding,
                    Row(
                      textBaseline: TextBaseline.alphabetic,
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('\$${sneaker.price}',
                            style: CustomTextStyle.headerStyle_30_black),
                        Row(
                          children: [
                            Text(
                              'Colors',
                              style: CustomTextStyle.titleStyle_17_black,
                            ),
                            ...List.generate(
                                3,
                                (index) => Container(
                                      margin: const EdgeInsets.only(left: 5),
                                      height:
                                          Dimens.getHeight(context: context) *
                                              0.03,
                                      width: Dimens.getWidth(context: context) *
                                          0.03,
                                      child: CircleAvatar(
                                        backgroundColor: index == 0
                                            ? Colors.black
                                            : index == 1
                                                ? Colors.red
                                                : Colors.grey,
                                      ),
                                    )),
                          ],
                        )
                      ],
                    ),
                    defaultPadding,
                    Row(
                      textBaseline: TextBaseline.alphabetic,
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Selecte Sizes',
                          style: CustomTextStyle.titleStyle_20_black,
                        ),
                        Text(
                          'View Size guide',
                          style: CustomTextStyle.titleStyle_15_grey,
                        )
                      ],
                    ),
                    defaultPadding,
                    const SizeField(),
                    defaultPadding,
                    const Divider(
                      color: Colors.black54,
                    ),
                    Text(sneaker.title,
                        style: CustomTextStyle.headerStyle_28_black),
                    Text(
                      sneaker.description,
                      style: CustomTextStyle.titleStyle_15_grey,
                    ),
                    defaultPadding,
                    Center(
                      child: ReusableButton(
                        label: 'Add to bag',
                        onTap: () async {
                          await cartNotifier.createCart(int.parse(sneaker.id), {
                            'id': sneaker.id,
                            'name': sneaker.name,
                            'category': sneaker.category,
                            'imageUrl': sneaker.imageUrl[0],
                            'sizes': sneaker.isSelectedSize,
                            'price': sneaker.price,
                            'qty': 1,
                          });
                          cartNotifier.getCart();
                          Navigator.pop(context);
                        },
                      ),
                    ),
                    const SizedBox(height: Dimens.dp40),
                  ],
                );
              }),
            ),
          ),
        ),
      ],
    );
  }
}
