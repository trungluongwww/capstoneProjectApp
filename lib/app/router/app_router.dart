import 'package:flutter/material.dart';
import 'package:roomeasy/app/screen/app_bottom_nav_bar.dart';
import 'package:roomeasy/app/screen/common/not_found.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    WidgetBuilder builder;
    switch (settings.name) {
      case AppBottomNavBar.routeName:
        builder = (context) => const AppBottomNavBar();
        break;
      default:
        builder = (context) => const NotFoundScreen();
        break;
    }

    return MaterialPageRoute(builder: builder, settings: settings);
  }
}
