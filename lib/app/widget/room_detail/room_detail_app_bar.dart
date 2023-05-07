// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:roomeasy/app/constant/app_color.dart';

class RoomDetailAppBar extends StatelessWidget with PreferredSizeWidget {
  final bool mount;
  const RoomDetailAppBar({
    Key? key,
    required this.mount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final appBarHeight = (screenHeight * 8 / 100).roundToDouble();
    return PreferredSize(
      preferredSize: Size.fromHeight(appBarHeight),
      child: AppBar(
        leading: const BackButton(color: AppColor.appPrimaryColor),
        backgroundColor: mount ? Colors.white70 : Colors.transparent,
        elevation: mount ? 2 : 0,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
