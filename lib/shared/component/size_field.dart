import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../view_model/sneaker_notifier.dart';
import '../preferences/preferences.dart';

class SizeField extends StatelessWidget {
  const SizeField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final sneakerNotifier = context.watch<SneakerNotifier>();
    final sneaker = sneakerNotifier.sneaker!;
    return SizedBox(
      height: Dimens.getHeight(
       context: context,
      )*0.05,
      child: ListView.builder(
        itemCount: sneakerNotifier.sneakerSizes.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final size = sneakerNotifier.sneakerSizes[index];
          return Padding(
            padding: const EdgeInsets.only(right: 10),
            child: ChoiceChip(
              selectedColor: Colors.black,
              labelStyle: size['isSelected']
                  ? CustomTextStyle.titleStyle_15_grey
                      .copyWith(color: Colors.white)
                  : CustomTextStyle.titleStyle_15_grey,
              label: Text(
                size['size'],
              ),
              selected: size['isSelected'],
              onSelected: (value) {
               
                if (sneaker.isSelectedSize!.contains(size['size'])) {
                  sneaker.isSelectedSize!.remove(size['size']);
                } else {
                  sneaker.isSelectedSize!.add(size['size']);
                }
                sneakerNotifier.toggleSizeCheck(index);
              },
            ),
          );
        },
      ),
    );
  }
}
