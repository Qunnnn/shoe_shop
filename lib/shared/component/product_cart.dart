import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:online_shop/controllers/controllers.dart';
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
    final favProvider = Provider.of<FavNotifier>(context);
    return SizedBox(
      height: Dimens.getHeight(context: context) * 0.36,
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
                    margin: const EdgeInsets.only(right: Dimens.dp16),
                    padding: const EdgeInsets.only(left: Dimens.dp10),
                    width: Dimens.getWidth(context: context) * 0.42,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          height: Dimens.getHeight(context: context) * 0.17,
                          width: Dimens.getWidth(context: context) * 0.4,
                          child: Stack(children: [
                            Align(
                              alignment: Alignment.topRight,
                              child: GestureDetector(
                                onTap: () {
                                  if (favProvider.ids.contains(sneaker.id)) {
                                    favProvider
                                        .deleteCart(int.parse(sneaker.id));
                                    favProvider.getFavIds();
                                    favProvider.getFav();
                                  } else {
                                    favProvider
                                        .createFav(int.parse(sneaker.id), {
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
                              ),
                            ),
                            Align(
                              alignment: Alignment.center,
                              child: CachedNetworkImage(
                                imageUrl: sneaker.imageUrl[0],
                                fit: BoxFit.fill,
                              ),
                            ),
                          ]),
                        ),
                        Expanded(
                          child: SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: Text(
                              sneaker.name,
                              style: CustomTextStyle.headerStyle_30_black,
                              overflow: TextOverflow.clip,
                            ),
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
                        const SizedBox(
                          height: Dimens.dp10,
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
