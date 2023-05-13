// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

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

  Map<String, dynamic>? _userData;
  AccessToken? _accessToken;
  bool _checking = true;

  void onPress() async {
    final accessToken = await FacebookAuth.instance.accessToken;
    setState(() {
      _checking = false;
    });

    if (accessToken != null) {
      print(accessToken.toJson());
      final userData = await FacebookAuth.instance.getUserData();
      _accessToken = accessToken;
      setState(() {
        _userData = userData;
      });
    } else {
      _login();
    }
  }

  void _login() async {
    final LoginResult rs = await FacebookAuth.instance.login();

    if (rs.status == LoginStatus.success) {
      _accessToken = rs.accessToken;
      final userData = await FacebookAuth.instance.getUserData();
      _userData = userData;
      print(_accessToken);
      print(userData);
    } else {
      print(rs.status);
      print(rs.message);
    }

    setState(() {
      _checking = false;
    });
  }

  void _logout() async {
    await FacebookAuth.instance.logOut();
    _accessToken = null;
    _userData = null;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const HomeAppBar(),
      backgroundColor: AppColor.appBackgroundColor,
      // body: SafeArea(
      //   bottom: true,
      //   child: Column(
      //     crossAxisAlignment: CrossAxisAlignment.center,
      //     children: [
      //       HomeHeader(bodyKey: bodyKey),
      //       const SizedBox(
      //         width: double.infinity,
      //         height: 8,
      //       ),
      //       Expanded(
      //           child: HomeBody(
      //         key: bodyKey,
      //       )),
      //     ],
      //   ),
      // ),
      body: Center(
        child: TextButton(onPressed: _login, child: const Text('Press herer ')),
      ),
    );
  }
}
