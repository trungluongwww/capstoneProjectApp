// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:roomeasy/app/constant/app_color.dart';
import 'package:roomeasy/app/constant/app_image.dart';
import 'package:roomeasy/app/provider/common/auth.dart';
import 'package:roomeasy/app/screen/account/account_screen.dart';
import 'package:roomeasy/app/screen/login/login.dart';
import 'package:roomeasy/app/widget/common/app_bar_action_item_with_bage.dart';
import 'package:roomeasy/model/auth/profile.dart';
import 'package:roomeasy/model/response/response.dart';

class HomeAppBar extends StatelessWidget with PreferredSizeWidget {
  final int countUnread;
  final int countNotificationAccount;

  const HomeAppBar({
    Key? key,
    this.countUnread = 0,
    this.countNotificationAccount = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final appBarHeight = (screenHeight * 8 / 100).roundToDouble();
    Widget loginButton = TextButton(
        onPressed: () {
          Navigator.of(context).pushNamed(LoginScreen.routerName);
        },
        child: const Text('Đăng nhập'));
    return PreferredSize(
      preferredSize: Size.fromHeight(appBarHeight),
      child: AppBar(
        leading: Image.asset(
          AppImage.logo,
          fit: BoxFit.contain,
          height: appBarHeight,
          width: 200,
        ),
        leadingWidth: 100,
        shadowColor: AppColor.appBackgroundColor,
        elevation: 0,
        toolbarHeight: appBarHeight,
        actions: [
          // AppBarActionItem(
          //     icon: Icons.message,
          //     onPress: () {},
          //     showNotification: false,
          //     showNumber: countUnread),

          // AppBarActionItem(
          //     icon: Icons.person,
          //     onPress: () {},
          //     showNotification: false,
          //     showNumber: countNotificationAccount),
          Consumer(builder: (context, ref, child) {
            final auth = ref.watch(authProfileProvider);
            if (auth != null) {
              return AppBarActionItem(
                  icon: Icons.person,
                  onPress: () {
                    Navigator.of(context).pushNamed(AccountScreen.routeName);
                  },
                  showNotification: false,
                  showNumber: countNotificationAccount);
            } else {
              return loginButton;
            }
          }),
        ],
        backgroundColor: AppColor.appBackgroundColor,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
