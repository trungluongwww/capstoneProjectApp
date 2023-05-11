import 'package:flutter/material.dart';
import 'package:roomeasy/app/constant/app_color.dart';

class LoginAppBar extends StatelessWidget with PreferredSizeWidget {
  const LoginAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final appBarHeight = (screenHeight * 8 / 100).roundToDouble();
    return PreferredSize(
      preferredSize: Size.fromHeight(appBarHeight),
      child: AppBar(
        leading: const BackButton(color: AppColor.appPrimaryColor),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
