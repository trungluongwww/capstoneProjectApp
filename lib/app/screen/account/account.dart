import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:roomeasy/app/constant/app_color.dart';
import 'package:roomeasy/app/provider/common/auth.dart';
import 'package:roomeasy/app/provider/common/bottom_navbar_index.dart';
import 'package:roomeasy/app/screen/account/tab_account_detail.dart';
import 'package:roomeasy/app/screen/account/tab_change_password.dart';
import 'package:roomeasy/app/screen/account/tab_room.dart';
import 'package:roomeasy/app/screen/home/home.dart';
import 'package:roomeasy/app/screen/login/login.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({Key? key}) : super(key: key);
  static const routeName = '/account';

  @override
  State createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text(
          'Tài khoản',
          style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: AppColor.textBlue),
        ),
        actions: [
          Consumer(
            builder: (context, ref, child) => TextButton(
                onPressed: () {
                  ref
                      .read(authProfileProvider.notifier)
                      .removeCurrentUserState();
                  ref.read(bottomNavbarIndexProvider.notifier).setIndex(0);
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      LoginScreen.routerName,
                      ModalRoute.withName(Home.routeName));
                },
                child: const Text(
                  'Đăng xuất',
                  style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: AppColor.primary),
                )),
          )
        ],
        centerTitle: true,
        bottom: TabBar(
          indicatorColor: AppColor.primary,
          isScrollable: false,
          unselectedLabelColor: Colors.black54,
          labelColor: AppColor.primary,
          labelStyle: const TextStyle(
              fontFamily: 'Inter', fontWeight: FontWeight.w500, fontSize: 14),
          controller: _tabController,
          tabs: const [
            Tab(
              text: 'Phòng',
            ),
            Tab(
              text: 'Cá nhân',
            ),
            Tab(
              text: 'Đổi mật khẩu',
            )
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        physics: const NeverScrollableScrollPhysics(),
        children: const [
          TabRoom(),
          TabAccountDetail(),
          TabChangePassword(),
        ],
      ),
    );
  }
}
