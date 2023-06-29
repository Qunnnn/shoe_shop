import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:online_shop/controllers/shoe_notifier.dart';
import 'package:online_shop/shared/preferences/preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:provider/provider.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key, required this.id, required this.category});
  final String id;
  final String category;

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  late ShoeNotifier sneakerProvider;
  final PageController _pageController = PageController();
  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      sneakerProvider = Provider.of<ShoeNotifier>(context, listen: false);
      if (widget.category == "Men's Running") {
        sneakerProvider.getMaleSnekerByid(id: widget.id);
      } else if (widget.category == "Women's Running") {
        sneakerProvider.getFemaleSnekerByid(id: widget.id);
      } else {
        sneakerProvider.getKidSnekerByid(id: widget.id);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final sneaker = context.watch<ShoeNotifier>();
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            expandedHeight: MediaQuery.of(context).size.height,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(
                    FontAwesomeIcons.xmark,
                    color: Colors.black,
                  ),
                ),
                const Icon(
                  FontAwesomeIcons.ellipsis,
                )
              ],
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: sneaker.sneaker == null
                  ? const Center(child: CircularProgressIndicator())
                  : Stack(
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
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(sneaker.sneaker!.name,
                                    style:
                                        CustomTextStyle.headerStyle_28_black),
                                Row(
                                  children: [
                                    Text(
                                      sneaker.sneaker!.category,
                                      style: CustomTextStyle.titleStyle_15_grey,
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
            ),
          )
        ],
      ),
    );
  }
}
