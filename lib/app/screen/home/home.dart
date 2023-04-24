import 'package:flutter/material.dart';
import 'package:roomeasy/app/constant/app_color.dart';
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
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final appBarHeight = (screenHeight * 8 / 100).roundToDouble();

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(appBarHeight),
        child: AppBar(
          leading: Image.asset(
            'assets/images/logo_main.png',
            fit: BoxFit.contain,
            height: appBarHeight,
            width: 200,
          ),
          leadingWidth: 100,
          shadowColor: AppColor.appBackgroundColor,
          elevation: 0,
          toolbarHeight: appBarHeight,
          actions: [
            AppBarActionItem(
                icon: Icons.message,
                onPress: () {
                  print(DateTime.now());
                },
                showNotification: false,
                showNumber: 0),
            AppBarActionItem(
                icon: Icons.message,
                onPress: () {},
                showNotification: false,
                showNumber: 10),
            AppBarActionItem(
                icon: Icons.message,
                onPress: () {},
                showNotification: false,
                showNumber: 10)
          ],
          backgroundColor: AppColor.appBackgroundColor,
        ),
      ),
      body: const Center(
        child: Text('Home'),
      ),
    );
  }
}
