import 'package:flutter/material.dart';

import '../preferences/preferences.dart';

class ReusableButton extends StatelessWidget {
  final Function()? onTap;
  final String label;
  const ReusableButton({super.key, required this.onTap, required this.label});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Dimens.getHeight(context: context) * 0.06,
      width: Dimens.getWidth(context: context) * 0.8,
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
