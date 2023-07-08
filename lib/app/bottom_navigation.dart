// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:roomeasy/app/constant/app_color.dart';
import 'package:roomeasy/app/provider/common/auth.dart';
import 'package:roomeasy/app/provider/common/bottom_navbar_index.dart';
import 'package:roomeasy/app/screen/account/account.dart';
import 'package:roomeasy/app/screen/conversation/conversation.dart';
import 'package:roomeasy/app/screen/favourite/favourite.dart';
import 'package:roomeasy/app/screen/home/home.dart';
import 'package:roomeasy/app/screen/login/login.dart';
import 'package:roomeasy/app/widget/common/modal_error.dart';

class BottomItem {
  final IconData iconData;
  final String text;
  const BottomItem({
    required this.iconData,
    required this.text,
  });
}

class BottomNavigation extends ConsumerStatefulWidget {
  const BottomNavigation({Key? key}) : super(key: key);

  @override
  _BottomNavigationState createState() => _BottomNavigationState();
}

class _BottomNavigationState extends ConsumerState<BottomNavigation> {
  final bottomItems = const <BottomItem>[
    BottomItem(iconData: Icons.home, text: "Trang chủ"),
    BottomItem(iconData: Icons.favorite, text: "Yêu thích"),
    BottomItem(iconData: Icons.message, text: "Tin nhắn"),
    BottomItem(iconData: Icons.person, text: "Tài khoản"),
  ];

  DateTime? currentBackTime;

  final _body = const [Home(), Favourite(), Conversation(), AccountScreen()];
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final now = DateTime.now();

        if (currentBackTime == null ||
            now.difference(currentBackTime!) > const Duration(seconds: 2)) {
          currentBackTime = now;
          ModalError().showToast(context, "200", "nhắn một lần nữa để thoát");
          return Future.value(false);
        }

        return Future.value(true);
      },
      child: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.shifting,
          currentIndex: ref.watch(bottomNavbarIndexProvider).index,
          onTap: (val) {
            if (ref.read(authProfileProvider) != null) {
              ref.read(bottomNavbarIndexProvider.notifier).setIndex(val);
            } else {
              Navigator.of(context).pushNamed(LoginScreen.routerName);
            }
          },
          elevation: 4,
          showUnselectedLabels: true,
          unselectedItemColor: AppColor.textBlue,
          selectedItemColor: AppColor.lightPrimary,
          items: bottomItems
              .map((e) => BottomNavigationBarItem(
                  icon: Icon(e.iconData), label: e.text))
              .toList(),
        ),
        body: IndexedStack(
            index: ref.watch(bottomNavbarIndexProvider).index, children: _body),
      ),
    );
  }
}
