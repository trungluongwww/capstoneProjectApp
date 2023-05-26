import 'package:flutter/material.dart';
import 'package:roomeasy/app/constant/app_color.dart';
import 'package:roomeasy/app/screen/account/tab_account_detail.dart';
import 'package:roomeasy/app/screen/account/tab_change_password.dart';
import 'package:roomeasy/app/screen/account/tab_room.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({Key? key}) : super(key: key);
  static const routeName = '/account';

  @override
  _AccountScreenState createState() => _AccountScreenState();
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
        leading: const BackButton(
          color: AppColor.appPrimaryColor,
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text(
          'Tài khoản',
          style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 16,
              fontWeight: FontWeight.w300,
              color: Colors.black),
        ),
        centerTitle: true,
        bottom: TabBar(
          isScrollable: false,
          unselectedLabelColor: Colors.black54,
          labelColor: AppColor.appPrimaryColor,
          labelStyle: const TextStyle(
              fontFamily: 'Inter', fontWeight: FontWeight.w300, fontSize: 14),
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
