import 'package:flutter/material.dart';
import 'package:roomeasy/app/screen/account/account.dart';
import 'package:roomeasy/app/screen/common/not_found.dart';
import 'package:roomeasy/app/screen/conversation/conversation.dart';
import 'package:roomeasy/app/screen/favourite/favourite.dart';
import 'package:roomeasy/app/screen/home/home.dart';
import 'package:roomeasy/app/screen/home_filter/home_filter.dart';

class AppRouter {
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
      case HomeFilter.routerName:
        builder = (context) => const HomeFilter();
        break;
      default:
        builder = (context) => const NotFoundScreen();
        break;
    }

    return MaterialPageRoute(
      builder: builder,
      settings: settings,
    );
  }
}
