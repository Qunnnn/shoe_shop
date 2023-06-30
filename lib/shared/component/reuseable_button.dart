import 'package:flutter/material.dart';

import '../preferences/preferences.dart';

class ReusableButton extends StatelessWidget {
  final Function()? onTap;
  final String label;
  const ReusableButton({super.key, required this.onTap, required this.label});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Dimens.getHeight(height: 40),
      width: Dimens.getWidth(width: 200),
      child: Material(
        color: Colors.black,
        clipBehavior: Clip.hardEdge,
        borderRadius: BorderRadius.circular(25),
        borderOnForeground: false,
        child: InkWell(
          onTap: onTap,
          child: Center(
            child: Text(
              label,
              style: CustomTextStyle.headerStyle_20_white,
            ),
          ),
        ),
      ),
    );
  }
}
