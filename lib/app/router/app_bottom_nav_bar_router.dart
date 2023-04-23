import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:roomeasy/app/screen/account/account.dart';
import 'package:roomeasy/app/screen/common/not_found.dart';
import 'package:roomeasy/app/screen/conversation/conversation.dart';
import 'package:roomeasy/app/screen/favourite/favourite.dart';
import 'package:roomeasy/app/screen/home/home.dart';

class AppBottomNavBarRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    WidgetBuilder builder;
    switch (settings.name) {
      case Home.routeName:
        builder = (context) => const Home();
        break;
      case Favourite.routeName:
        builder = (context) => const Favourite();
        break;
      case Conversation.routeName:
        builder = (context) => const Conversation();
        break;
      case Account.routeName:
        builder = (context) => const Account();
        break;
      default:
        builder = (context) => const NotFoundScreen();
        break;
    }

    return MaterialPageRoute(builder: builder, settings: settings);
  }
}
