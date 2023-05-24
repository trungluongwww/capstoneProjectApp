import 'package:flutter/material.dart';
import 'package:roomeasy/api/services/auth/auth.dart';
import 'package:roomeasy/app/screen/account/account.dart';
import 'package:roomeasy/app/screen/conversation/conversation.dart';
import 'package:roomeasy/app/screen/favourite/favourite.dart';
import 'package:roomeasy/app/screen/home/home.dart';
import 'package:roomeasy/app/screen/home_filter/home_filter.dart';
import 'package:roomeasy/app/screen/location/location.dart';
import 'package:roomeasy/app/screen/login/login.dart';
import 'package:roomeasy/app/screen/register/register.dart';
import 'package:roomeasy/app/screen/room/room_create.dart';
import 'package:roomeasy/app/screen/room/room_detail.dart';
import 'package:roomeasy/form/location/location.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    bool isLogged = AuthServices().getCurrentUserState() != null;

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
      case AccountScreen.routeName:
        builder =
            (context) => isLogged ? const AccountScreen() : const LoginScreen();

        break;
      case HomeFilterScreen.routerName:
        builder = (context) => const HomeFilterScreen();
        break;
      case RoomDetailScreen.routeName:
        final id = (settings.arguments as Map<String, dynamic>)['id'];
        builder = (context) => RoomDetailScreen(
              id: id ?? '',
            );
        break;
      case SelectLocationScreen.routerName:
        LocationFormModel? formdata = settings.arguments as LocationFormModel;
        builder = (context) => SelectLocationScreen(input: formdata);
        break;
      case RegisterScreen.routerName:
        builder = (context) => const RegisterScreen();
        break;
      case RoomCreate.routeName:
        builder =
            (context) => isLogged ? const RoomCreate() : const LoginScreen();
        break;
      case LoginScreen.routerName:
      default:
        builder = (context) => const LoginScreen();
        break;
    }

    return MaterialPageRoute(
      builder: builder,
      settings: settings,
    );
  }
}
