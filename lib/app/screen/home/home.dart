// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:roomeasy/app/constant/app_color.dart';
import 'package:roomeasy/app/screen/common/no_network_screen.dart';
import 'package:roomeasy/app/screen/room/room_create.dart';
import 'package:roomeasy/app/widget/home/home_app_bar.dart';
import 'package:roomeasy/app/widget/home/home_body.dart';
import 'package:roomeasy/app/widget/home/home_header.dart';
import 'package:roomeasy/network/connection.dart';

class Home extends StatefulWidget {
  static const String routeName = '/';
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  StreamSubscription? _trackingNetwork;
  @override
  void initState() {
    final ConnectionNetwork instance = ConnectionNetwork.getInstance();
    _trackingNetwork = instance.streamNetwork.listen((event) {
      if (!event) {
        Navigator.of(context).pushNamedAndRemoveUntil(
            NoNetworkScreen.routerName, (Route route) => false);
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _trackingNetwork?.cancel();
    super.dispose();
  }

  // global key
  final GlobalKey<HomeBodyState> bodyKey = GlobalKey<HomeBodyState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const HomeAppBar(),
        backgroundColor: Colors.white,
        body: SafeArea(
          top: true,
          bottom: true,
          child: Column(
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
        ),
        floatingActionButton: Container(
          padding: const EdgeInsets.all(2),
          width: 100,
          height: 40,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
          clipBehavior: Clip.hardEdge,
          child: Material(
            color: AppColor.primary,
            elevation: 4,
            child: InkWell(
              onTap: () {
                Navigator.of(context).pushNamed(RoomCreate.routeName);
              },
              splashColor: Colors.grey,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: const [
                  Icon(
                    Icons.add,
                    color: Colors.white,
                    size: 14,
                  ),
                  Text('Đăng phòng',
                      style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Colors.white))
                ],
              ),
            ),
          ),
        ));
  }
}
