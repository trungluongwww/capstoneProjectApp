// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class ListTitleSmallWithoutSpacing extends StatelessWidget {
  /// list title small without spacing and default grey color

  final String? title;
  final String defaultTitle;
  final IconData leadIcon;
  final Color? colorLeadIcon;
  final Color? colorTitleIcon;
  final String? prefixTitle;
  const ListTitleSmallWithoutSpacing({
    Key? key,
    this.title,
    required this.defaultTitle,
    required this.leadIcon,
    this.colorLeadIcon,
    this.colorTitleIcon,
    this.prefixTitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      horizontalTitleGap: 0,
      visualDensity: const VisualDensity(
          vertical: VisualDensity.minimumDensity,
          horizontal: VisualDensity.minimumDensity),
      contentPadding: EdgeInsets.zero,
      dense: true,
      leading: Icon(
        leadIcon,
        color: colorLeadIcon ?? Colors.black54,
      ),
      title: title != null
          ? Text(
              '${prefixTitle ?? ""}${prefixTitle != null ? ": " : ""}$title',
              style: TextStyle(
                  fontFamily: "Inter",
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: colorTitleIcon ?? Colors.black54,
                  overflow: TextOverflow.ellipsis),
            )
          : Text(defaultTitle),
    );
  }
}
