// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:roomeasy/app/constant/app_color.dart';
import 'package:roomeasy/app/widget/home/home_app_bar.dart';
import 'package:roomeasy/app/widget/home/home_body.dart';
import 'package:roomeasy/app/widget/home/home_header.dart';

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

  // global key
  final GlobalKey<HomeBodyState> bodyKey = GlobalKey<HomeBodyState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const HomeAppBar(countUnread: 3, countNotificationAccount: 2),
      backgroundColor: AppColor.appBackgroundColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          HomeHeader(bodyKey: bodyKey),
          const SizedBox(
            width: double.infinity,
            height: 8,
          ),
          Expanded(
              child: HomeBody(
            key: bodyKey,
          )),
        ],
      ),
    );
  }
}
