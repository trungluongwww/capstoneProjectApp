// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:roomeasy/app/constant/app_color.dart';
import 'package:roomeasy/app/screen/room/room_create.dart';
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
        appBar: const HomeAppBar(),
        backgroundColor: AppColor.appBackgroundColor,
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
          height: 32,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
          clipBehavior: Clip.hardEdge,
          child: Material(
            color: AppColor.appPrimaryColor,
            elevation: 4,
            child: InkWell(
              onTap: () {
                Navigator.of(context).pushNamed(RoomCreate.routeName);
              },
              splashColor: AppColor.appBlurPrimaryColor,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Icon(
                    Icons.add,
                    color: Colors.white,
                    size: 14,
                  ),
                  Text(
                    'Đăng phòng',
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(color: Colors.white, fontSize: 12),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
