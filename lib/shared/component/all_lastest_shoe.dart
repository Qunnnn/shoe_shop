import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import '../../models/sneaker_model.dart';
import '../preferences/preferences.dart';

class AllLastestShoeWidget extends StatelessWidget {
  const AllLastestShoeWidget({super.key, required this.sneakers});
  final List<SneakerModel> sneakers;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: StaggeredGridView.countBuilder(
          crossAxisCount: 2,
          crossAxisSpacing: Dimens.dp10,
          scrollDirection: Axis.vertical,
          itemCount: sneakers.length,
          mainAxisSpacing: Dimens.dp10,
          staggeredTileBuilder: (index) {
            return StaggeredTile.extent(
                1,
                index.isOdd
                    ? Dimens.getHeight(context: context, height: 330)
                    : Dimens.getHeight(context: context, height: 300));
          },
          itemBuilder: (context, index) => AnimationConfiguration.staggeredGrid(
            position: index,
            duration: const Duration(milliseconds: 800),
            columnCount: sneakers.length,
            child: ScaleAnimation(
              child: FadeInAnimation(
                curve: Curves.easeInOut,
                child: Container(
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
                        height: index.isOdd ? Dimens.dp20 : 0,
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Text(
                            sneakers[index].name,
                            style: CustomTextStyle.headerStyle_30_black,
                            textAlign: TextAlign.start,
                            softWrap: true,
                          ),
                        ),
                      ),
                      Text(
                        '\$${sneakers[index].price}',
                        style: CustomTextStyle.titleStyle_20_black,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}
