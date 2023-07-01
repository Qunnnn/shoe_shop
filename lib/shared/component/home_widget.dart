import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:online_shop/shared/component/component.dart';
import 'package:online_shop/views/views.dart';
import '../../models/sneaker_model.dart';
import '../preferences/preferences.dart';

class HomeWidget extends StatelessWidget {
  const HomeWidget({
    super.key,
    required this.sneakers,
    required this.tabIndex,
  });
  final int tabIndex;
  final List<SneakerModel> sneakers;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ProductCard(sneakers: sneakers),
        const SizedBox(
          height: Dimens.dp10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Latest Shoe',
              style: CustomTextStyle.titleStyle_17_black,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AllLastestScreen(
                        tabIndex: tabIndex,
                      ),
                    ));
              },
              child: Row(
                children: [
                  Text(
                    'Show all',
                    style: CustomTextStyle.titleStyle_17_black
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  const Icon(
                    FontAwesomeIcons.caretRight,
                    size: 18,
                  ),
                ],
              ),
            ),
          ],
        ),
       const SizedBox(
          height: Dimens.dp10,
        ),
        NewShoe(
          sneakers: sneakers,
        ),
      ],
    );
  }
}
