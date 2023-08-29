// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:roomeasy/app/constant/app_color.dart';

class ButtonIconFlatPrimary extends StatelessWidget {
  final double size;
  final VoidCallback onClick;
  final IconData? icon;
  final double? iconSize;

  const ButtonIconFlatPrimary({
    Key? key,
    required this.size,
    required this.onClick,
    this.icon,
    this.iconSize = 24,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
          color: AppColor.lightPrimary),
      child: IconButton(
        padding: EdgeInsets.zero,
        alignment: Alignment.center,
        icon: Icon(
          icon ?? Icons.tune,
          color: AppColor.white,
          size: 24,
          weight: 0.1,
        ),
        onPressed: onClick,
      ),
    );
  }
}
