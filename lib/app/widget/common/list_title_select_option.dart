import 'package:flutter/material.dart';
import 'package:roomeasy/app/constant/app_color.dart';

class ListTitleSelectOption extends StatelessWidget {
  final String title;
  final Color? titleColor;
  final Icon? trailing;
  final VoidCallback? onTab;

  const ListTitleSelectOption({
    Key? key,
    required this.title,
    this.titleColor = Colors.black,
    this.trailing,
    this.onTab,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 56,
      child: Material(
        color: Colors.white,
        child: InkWell(
          onTap: onTab,
          child: ListTile(
            title: Text(
              title,
              style: TextStyle(
                color: titleColor,
                fontSize: 14,
              ),
            ),
            trailing: trailing,
          ),
        ),
      ),
    );
  }
}
