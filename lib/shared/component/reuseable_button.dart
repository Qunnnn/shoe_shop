import 'package:flutter/material.dart';

import '../preferences/preferences.dart';

class ReusableButton extends StatelessWidget {
  const ReusableButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Dimens.getHeight(height: 40),
      width: Dimens.getWidth(width: 230),
      decoration: BoxDecoration(
          color: Colors.black,
          borderRadius:
              BorderRadius.circular(15)),
      child: Center(
        child: Text(
          'Add to bag',
          style: CustomTextStyle
              .headerStyle_20_white,
        ),
      ),
    );
  }
}