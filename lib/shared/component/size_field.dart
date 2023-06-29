import 'package:flutter/material.dart';

import '../../controllers/sneaker_notifier.dart';
import '../preferences/preferences.dart';

class SizeField extends StatelessWidget {
  const SizeField({
    super.key,
    required this.sneaker,
  });

  final SneakerNotifier sneaker;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Dimens.getHeight(
        height: 50,
      ),
      child: ListView.builder(
        itemCount: sneaker.sneakerSizes.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Padding(
            padding:
                const EdgeInsets.only(right: 10),
            child: ChoiceChip(
              selectedColor: Colors.black,
              labelStyle: sneaker
                          .sneakerSizes[index]
                      ['isSelected']
                  ? CustomTextStyle
                      .titleStyle_15_grey
                      .copyWith(
                          color: Colors.white)
                  : CustomTextStyle
                      .titleStyle_15_grey,
              label: Text(
                sneaker.sneakerSizes[index]
                    ['size'],
              ),
              selected:
                  sneaker.sneakerSizes[index]
                      ['isSelected'],
              onSelected: (value) {
                sneaker.toggleSizeCheck(index);
              },
            ),
          );
        },
      ),
    );
  }
}