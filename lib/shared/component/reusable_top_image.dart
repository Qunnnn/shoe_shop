import 'package:flutter/material.dart';

import '../preferences/preferences.dart';

class ReusableTopImage extends StatelessWidget {
  const ReusableTopImage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: Dimens.dp20, vertical: Dimens.dp26),
      height: Dimens.getHeight(context: context) * 0.22,
      width: double.infinity,
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage(AssetPath.topImage), fit: BoxFit.fill)),
    );
  }
}