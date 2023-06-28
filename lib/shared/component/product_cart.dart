import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:online_shop/models/shoe_model.dart';
import '../preferences/preferences.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
    required this.sneakers,
  });

  final List<ShoeModel> sneakers;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Dimens.getHeight(height: 300),
      child: sneakers.isEmpty
          ? const Center(
              child: CircularProgressIndicator(
              color: Colors.black,
            ))
          : ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: sneakers.length,
              itemBuilder: (context, index) {
                final sneaker = sneakers[index];
                return Container(
                  margin: EdgeInsets.only(right: Dimens.dwp15),
                  padding: EdgeInsets.only(left: Dimens.dwp10),
                  width: Dimens.getWidth(width: 200),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        height: Dimens.getHeight(height: 150),
                        width: Dimens.getWidth(width: 190),
                        child: Stack(children: [
                          const Align(
                              alignment: Alignment.topRight,
                              child: Icon(
                                FontAwesomeIcons.heart,
                                color: Colors.grey,
                              )),
                          Align(
                            alignment: Alignment.center,
                            child: CachedNetworkImage(
                              imageUrl: sneaker.imageUrl[0],
                              fit: BoxFit.cover,
                            ),
                          ),
                        ]),
                      ),
                      Text(
                        sneaker.name,
                        style: CustomTextStyle.headerStyle_30.copyWith(
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        sneaker.category,
                        style: CustomTextStyle.titleStyle_15,
                      ),
                      Text(
                        '\$${sneaker.price}',
                        style: CustomTextStyle.titleStyle_20,
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
