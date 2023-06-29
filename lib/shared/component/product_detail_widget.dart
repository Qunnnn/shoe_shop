import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:online_shop/shared/component/component.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../controllers/sneaker_notifier.dart';
import '../preferences/preferences.dart';

class ProductDetailWidget extends StatelessWidget {
  const ProductDetailWidget({
    super.key,
    required PageController pageController,
    required this.sneaker,
    required this.defaultPadding,
  }) : _pageController = pageController;

  final PageController _pageController;
  final SneakerNotifier sneaker;
  final SizedBox defaultPadding;

  @override
  Widget build(BuildContext context) {
    return Stack(
        children: [
          SizedBox(
            height: Dimens.getHeight(height: 300),
            width: double.infinity,
            child: PageView.builder(
              controller: _pageController,
              itemCount: sneaker.sneaker!.imageUrl.length,
              onPageChanged: (value) {},
              itemBuilder: (context, index) {
                return Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      color: Colors.grey[400],
                      child: CachedNetworkImage(
                          imageUrl:
                              sneaker.sneaker!.imageUrl[index]),
                    ),
                    Positioned(
                        top: Dimens.getHeight(height: 70),
                        right: Dimens.getWidth(width: 30),
                        child: GestureDetector(
                          onTap: () {},
                          child: const Icon(
                            FontAwesomeIcons.heart,
                            color: Colors.grey,
                          ),
                        )),
                    Padding(
                      padding:
                          EdgeInsets.only(bottom: Dimens.dhp25),
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: SmoothPageIndicator(
                          controller: _pageController,
                          count: sneaker.sneaker!.imageUrl.length,
                          effect: JumpingDotEffect(
                            activeDotColor: Colors.black,
                            dotColor: Colors.grey,
                            dotHeight:
                                Dimens.getHeight(height: 10),
                            dotWidth: Dimens.getWidth(width: 10),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: const EdgeInsets.all(10),
              height: Dimens.getHeight(height: 500),
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20)),
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(sneaker.sneaker!.name,
                        style:
                            CustomTextStyle.headerStyle_28_black),
                    defaultPadding,
                    Row(
                      children: [
                        Text(
                          sneaker.sneaker!.category,
                          style:
                              CustomTextStyle.titleStyle_15_grey,
                        ),
                        SizedBox(
                          width: Dimens.dwp20,
                        ),
                        RatingBar.builder(
                          itemSize: 20,
                          initialRating: 3,
                          minRating: 1,
                          maxRating: 5,
                          unratedColor: Colors.grey,
                          allowHalfRating: true,
                          itemBuilder: (context, index) =>
                              const Icon(
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
                      crossAxisAlignment:
                          CrossAxisAlignment.baseline,
                      mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                      children: [
                        Text('\$${sneaker.sneaker!.price}',
                            style: CustomTextStyle
                                .headerStyle_30_black),
                        Row(
                          children: [
                            Text(
                              'Colors',
                              style: CustomTextStyle
                                  .titleStyle_17_black,
                            ),
                            ...List.generate(
                                3,
                                (index) => Container(
                                      margin:
                                          const EdgeInsets.only(
                                              left: 5),
                                      height: Dimens.getHeight(
                                          height: 15),
                                      width: Dimens.getWidth(
                                          width: 15),
                                      child: CircleAvatar(
                                        backgroundColor:
                                            index == 0
                                                ? Colors.black
                                                : index == 1
                                                    ? Colors.red
                                                    : Colors.grey,
                                      ),
                                    ))
                          ],
                        )
                      ],
                    ),
                    defaultPadding,
                    Row(
                      textBaseline: TextBaseline.alphabetic,
                      crossAxisAlignment:
                          CrossAxisAlignment.baseline,
                      mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Selecte Sizes',
                          style:
                              CustomTextStyle.titleStyle_20_black,
                        ),
                        Text(
                          'View Size guide',
                          style:
                              CustomTextStyle.titleStyle_15_grey,
                        )
                      ],
                    ),
                    SizeField(sneaker: sneaker),
                    const Divider(
                      color: Colors.black54,
                    ),
                    Text(sneaker.sneaker!.title,
                        style:
                            CustomTextStyle.headerStyle_28_black),
                    Text(
                      sneaker.sneaker!.description,
                      style: CustomTextStyle.titleStyle_15_grey,
                    ),
                    defaultPadding,
                    const Center(
                      child: ReusableButton(),
                    ),
                    SizedBox(
                      height: Dimens.getHeight(height: 30),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      );
  }
}