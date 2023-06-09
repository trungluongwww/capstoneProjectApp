// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:roomeasy/app/constant/app_color.dart';
import 'package:roomeasy/app/constant/app_image.dart';
import 'package:roomeasy/app/provider/common/auth.dart';
import 'package:roomeasy/app/screen/account/account.dart';
import 'package:roomeasy/app/screen/conversation/conversation.dart';
import 'package:roomeasy/app/screen/favourite/favourite.dart';
import 'package:roomeasy/app/screen/login/login.dart';
import 'package:roomeasy/app/widget/common/app_bar_action_item_with_bage.dart';

class HomeAppBar extends StatelessWidget with PreferredSizeWidget {
  final int? unreadMessage;
  const HomeAppBar({
    Key? key,
    this.unreadMessage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> getAppBarActions() {
      return [
        AppBarActionItem(
            icon: Icons.message,
            onPress: () {
              Navigator.of(context).pushNamed(Conversation.routeName);
            },
            showNotification: false,
            showNumber: 0),
        AppBarActionItem(
            icon: Icons.favorite,
            onPress: () {
              Navigator.of(context).pushNamed(Favourite.routeName);
            },
            showNotification: false,
            showNumber: 0),
        AppBarActionItem(
            icon: Icons.settings,
            onPress: () {
              Navigator.of(context).pushNamed(AccountScreen.routeName);
            },
            showNotification: unreadMessage != null,
            showNumber: unreadMessage ?? 0),
      ];
    }

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
          leading: Image.asset(
            AppImage.logo,
            fit: BoxFit.contain,
            height: appBarHeight,
            width: 200,
          ),
          leadingWidth: 100,
          shadowColor: AppColor.white,
          elevation: 0,
          toolbarHeight: appBarHeight,
          actions: auth != null ? getAppBarActions() : [loginButton],
          backgroundColor: AppColor.white,
        );
      }),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
