import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:roomeasy/app/constant/app_color.dart';
import 'package:roomeasy/app/router/app_bottom_nav_bar_router.dart';
import 'package:roomeasy/app/screen/account/account.dart';
import 'package:roomeasy/app/screen/conversation/conversation.dart';
import 'package:roomeasy/app/screen/favourite/favourite.dart';
import 'package:roomeasy/app/screen/home/home.dart';

class AppBottomNavBar extends StatefulWidget {
  const AppBottomNavBar({Key? key}) : super(key: key);

  static const routeName = '/';

  @override
  _AppBottomNavBarState createState() => _AppBottomNavBarState();
}

class _AppBottomNavBarState extends State<AppBottomNavBar> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  static const List<BottomNavigationBarItem> _bottomNavItems = [
    BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: "Home",
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.favorite),
      label: "Favourite",
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.message),
      label: "Conversation",
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.person),
      label: "Account",
    ),
  ];

  int _selectedIndex = 0;

  void _onSelectedItem(BuildContext ctx, int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        _navigatorKey.currentState!
            .popUntil(ModalRoute.withName(Home.routeName));
        break;
      case 1:
        _navigatorKey.currentState!.pushNamedAndRemoveUntil(
            Favourite.routeName, ModalRoute.withName(Home.routeName));
        break;
      case 2:
        _navigatorKey.currentState!.pushNamedAndRemoveUntil(
            Conversation.routeName, ModalRoute.withName(Home.routeName));
        break;
      case 3:
        _navigatorKey.currentState!.pushNamedAndRemoveUntil(
            Account.routeName, ModalRoute.withName(Home.routeName));
        break;
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: () async {
          return true;
        },
        child: Navigator(
          key: _navigatorKey,
          initialRoute: Home.routeName,
          onGenerateRoute: AppBottomNavBarRouter.generateRoute,
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        showUnselectedLabels: true,
        selectedItemColor: AppColor.appPrimaryColor,
        unselectedItemColor: AppColor.appUnselectedColor,
        items: _bottomNavItems,
        currentIndex: _selectedIndex,
        onTap: (index) => _onSelectedItem(context, index),
      ),
    );
  }
}
