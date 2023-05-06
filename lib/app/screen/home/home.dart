// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:roomeasy/app/constant/app_color.dart';
import 'package:roomeasy/app/screen/home/home_app_bar.dart';
import 'package:roomeasy/app/screen/home/home_body.dart';
import 'package:roomeasy/app/screen/home/home_header.dart';

class Home extends StatefulWidget {
  static const String routeName = '/';
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const HomeAppBar(countUnread: 3, countNotificationAccount: 2),
      backgroundColor: AppColor.appBackgroundColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: const [
          HomeHeader(),
          SizedBox(
            width: double.infinity,
            height: 8,
          ),
          Expanded(child: HomeBody()),
        ],
      ),
    );
  }
}
