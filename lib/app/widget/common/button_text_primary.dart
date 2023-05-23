// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:roomeasy/app/constant/app_color.dart';

class ButtonTextPrimary extends StatelessWidget {
  final double maxWidth;
  final double height;
  final VoidCallback onClick;
  final String title;
  final TextStyle? style;

  const ButtonTextPrimary({
    Key? key,
    this.maxWidth = double.infinity,
    required this.height,
    required this.onClick,
    required this.title,
    this.style,
  }) : super(key: key);

  @override
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxWidth: maxWidth),
      height: height,
      child: Material(
        color: Colors.blue,
        child: InkWell(
          onTap: onClick,
          child: Center(
            child: Text(
              overflow: TextOverflow.ellipsis,
              title,
              style: style ??
                  const TextStyle(
                      fontFamily: "Inter",
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      color: AppColor.appBackgroundColor),
            ),
          ),
        ),
      ),
    );
  }
}
