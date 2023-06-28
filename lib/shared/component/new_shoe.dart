import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../models/shoe_model.dart';
import '../preferences/preferences.dart';

class NewShoe extends StatelessWidget {
  const NewShoe({super.key, required this.sneakers});
  final List<ShoeModel> sneakers;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Dimens.getHeight(height: 130),
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
                  margin: EdgeInsets.only(right: Dimens.dwp15),
                  width: Dimens.getWidth(width: 120),
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
