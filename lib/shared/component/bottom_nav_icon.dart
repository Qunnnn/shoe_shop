import 'package:flutter/material.dart';

class BottomNavIcon extends StatelessWidget {
  final IconData? icon;
  final Color? clr;
  final Function()? onTap;
  const BottomNavIcon(
      {super.key, required this.icon, required this.clr, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Icon(
        icon,
        color: clr,
      ),
    );
  }
}
