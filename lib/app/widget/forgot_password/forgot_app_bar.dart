import 'package:flutter/material.dart';
import 'package:roomeasy/app/constant/app_color.dart';

class ForgotAppBar extends StatelessWidget with PreferredSizeWidget {
  const ForgotAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final appBarHeight = (screenHeight * 8 / 100).roundToDouble();
    return PreferredSize(
      preferredSize: Size.fromHeight(appBarHeight),
      child: AppBar(
        leading: const BackButton(color: AppColor.primary),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Quên mật khẩu",
          style: TextStyle(
            fontFamily: "Inter",
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
