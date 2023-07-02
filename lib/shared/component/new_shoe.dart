import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../models/sneaker_model.dart';
import '../preferences/preferences.dart';

class NewShoe extends StatelessWidget {
  const NewShoe({super.key, required this.sneakers});
  final List<SneakerModel> sneakers;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Dimens.getHeight(context: context) * 0.15,
      child: sneakers.isEmpty
          ? const Center(
              child: CircularProgressIndicator(
              color: Colors.black,
            ))
          : ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: sneakers.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.only(right: Dimens.dp16),
                  width: Dimens.getWidth(context: context) * 0.3,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15)),
                  child: Padding(
                    padding: const EdgeInsets.all(7.0),
                    child: CachedNetworkImage(
                        imageUrl: sneakers[index].imageUrl[1]),
                  ),
                );
              },
            ),
    );
  }
}
