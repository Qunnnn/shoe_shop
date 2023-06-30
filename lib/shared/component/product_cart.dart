import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:online_shop/controllers/sneaker_notifier.dart';
import 'package:online_shop/models/sneaker_model.dart';
import 'package:online_shop/views/views.dart';
import 'package:provider/provider.dart';
import '../preferences/preferences.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
    required this.sneakers,
  });

  final List<SneakerModel> sneakers;

  @override
  Widget build(BuildContext context) {
    final sneakerProvider = Provider.of<SneakerNotifier>(context);
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
                return GestureDetector(
                  onTap: () {
                    sneakerProvider.sneakerSizes = sneakers[index].sizes;
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductScreen(
                            id: sneaker.id,
                            category: sneaker.category,
                          ),
                        ));
                  },
                  child: Container(
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
                        SizedBox(
                          height: Dimens.getHeight(height: 85),
                          child: Text(
                            sneaker.name,
                            style: CustomTextStyle.headerStyle_30_black,
                            overflow: TextOverflow.clip,
                          ),
                        ),
                        Text(
                          sneaker.category,
                          style: CustomTextStyle.titleStyle_15_grey,
                        ),
                        Text(
                          '\$${sneaker.price}',
                          style: CustomTextStyle.titleStyle_20_black,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
