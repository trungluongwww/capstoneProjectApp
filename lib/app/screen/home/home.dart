import 'package:flutter/material.dart';
import 'package:roomeasy/api/auth/auth.dart';
import 'package:roomeasy/app/constant/app_color.dart';
import 'package:roomeasy/app/screen/home/home_app_bar.dart';
import 'package:roomeasy/app/widget/shared/app_bar_action_item.dart';

class Home extends StatefulWidget {
  static const String routeName = '/';
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @protected
  @mustCallSuper
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HomeAppBar(countUnread: 3, countNotificationAccount: 2),
      backgroundColor: AppColor.appBackgroundColor,
      body: Center(
        child: TextButton(
            onPressed: () async {
              var token = await AuthAPI().login('admin', '123456');
              print("token");
              print(token);
            },
            child: Text("fetch ne")),
      ),
    );
  }
}
