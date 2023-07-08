// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:roomeasy/app/constant/app_color.dart';
import 'package:roomeasy/app/constant/app_image.dart';
import 'package:roomeasy/app/provider/common/auth.dart';

import 'package:roomeasy/app/screen/login/login.dart';

class HomeAppBar extends StatelessWidget with PreferredSizeWidget {
  final int? unreadMessage;
  const HomeAppBar({
    Key? key,
    this.unreadMessage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final appBarHeight = (screenHeight * 8 / 100).roundToDouble();
    Widget loginButton = TextButton(
        onPressed: () {
          Navigator.of(context).pushNamed(LoginScreen.routerName);
        },
        child: const Text(
          'Đăng nhập',
          style: TextStyle(
              fontFamily: 'Inter',
              fontWeight: FontWeight.w500,
              fontSize: 14,
              color: AppColor.textBlue),
        ));
    return PreferredSize(
      preferredSize: Size.fromHeight(appBarHeight),
      child: Consumer(builder: (context, ref, child) {
        final auth = ref.watch(authProfileProvider);
        return AppBar(
          leading: Center(
            child: Image.asset(
              AppImage.logo,
              fit: BoxFit.contain,
              height: appBarHeight,
              width: appBarHeight,
            ),
          ),
          leadingWidth: 100,
          shadowColor: AppColor.white,
          elevation: 0,
          toolbarHeight: appBarHeight,
          actions: auth != null
              ? [
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: Text(
                        "xin chào ${auth.name ?? ""}",
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            color: AppColor.textBlue,
                            fontFamily: 'Inter',
                            fontSize: 14,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  )
                ]
              : [loginButton],
          backgroundColor: AppColor.white,
        );
      }),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
