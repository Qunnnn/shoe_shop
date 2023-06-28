import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import '../../models/shoe_model.dart';
import '../preferences/preferences.dart';

class AllLastestShoeWidget extends StatelessWidget {
  const AllLastestShoeWidget({super.key, required this.sneakers});
  final List<ShoeModel> sneakers;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: StaggeredGridView.countBuilder(
          crossAxisCount: 2,
          crossAxisSpacing: Dimens.dwp10,
          scrollDirection: Axis.vertical,
          itemCount: sneakers.length,
          mainAxisSpacing: Dimens.dhp10,
          staggeredTileBuilder: (index) {
            return StaggeredTile.extent(
                1,
                index.isOdd
                    ? Dimens.getHeight(height: 360)
                    : Dimens.getHeight(height: 300));
          },
          itemBuilder: (context, index) => Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CachedNetworkImage(
                  imageUrl: sneakers[index].imageUrl[1],
                  fit: BoxFit.fill,
                ),
                SizedBox(
                  height: index.isOdd ? Dimens.dhp20 : 0,
                ),
                Text(
                  sneakers[index].name,
                  style: CustomTextStyle.headerStyle_30.copyWith(
                    color: Colors.black,
                  ),
                ),
                Text(
                  '\$${sneakers[index].price}',
                  style: CustomTextStyle.titleStyle_20,
                ),
              ],
            ),
          ),
        ));
  }
}
