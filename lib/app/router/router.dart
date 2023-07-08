import 'package:flutter/material.dart';
import 'package:roomeasy/api/services/auth/auth.dart';
import 'package:roomeasy/app/screen/account/account.dart';
import 'package:roomeasy/app/screen/common/no_network_screen.dart';
import 'package:roomeasy/app/screen/conversation/conversation.dart';
import 'package:roomeasy/app/screen/conversation/conversation_detail.dart';
import 'package:roomeasy/app/screen/conversation/conversation_detail_by_user.dart';
import 'package:roomeasy/app/screen/favourite/favourite.dart';
import 'package:roomeasy/app/screen/forgot/forgot_password.dart';
import 'package:roomeasy/app/screen/home/home.dart';
import 'package:roomeasy/app/screen/home_filter/home_filter.dart';
import 'package:roomeasy/app/screen/location/location.dart';
import 'package:roomeasy/app/screen/login/login.dart';
import 'package:roomeasy/app/screen/register/register.dart';
import 'package:roomeasy/app/screen/reset_password/reset_password.dart';
import 'package:roomeasy/app/screen/room/room_create.dart';
import 'package:roomeasy/app/screen/room/room_detail.dart';
import 'package:roomeasy/app/screen/room/room_update.dart';
import 'package:roomeasy/form/location/location.dart';
import 'package:roomeasy/model/room/room.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    bool isLogged = AuthServices().getCurrentUserState() != null;

    WidgetBuilder builder;
    switch (settings.name) {
      case NoNetworkScreen.routerName:
        builder = (context) => const NoNetworkScreen();
        break;
      case Home.routeName:
        builder = (context) => const Home();
        break;
      case Favourite.routeName:
        builder =
            (context) => isLogged ? const Favourite() : const LoginScreen();
        break;
      case Conversation.routeName:
        builder =
            (context) => isLogged ? const Conversation() : const LoginScreen();
        break;
      case ConversationDetail.routeName:
        final conversationId =
            (settings.arguments as Map<String, dynamic>)['id'];
        final roomAttach = (settings.arguments as Map<String, dynamic>)['room'];
        RoomModel? room;

        if (roomAttach is RoomModel) {
          room = roomAttach;
        }

        builder = (context) => isLogged
            ? ConversationDetail(
                conversationId: conversationId,
                attachRoom: room,
              )
            : const LoginScreen();
        break;
      case ConversationDetailByUser.routeName:
        final targetId = (settings.arguments as Map<String, dynamic>)['id'];
        final roomAttach = (settings.arguments as Map<String, dynamic>)['room'];
        RoomModel? room;

        if (roomAttach is RoomModel) {
          room = roomAttach;
        }

        builder = (context) => isLogged
            ? ConversationDetailByUser(
                targetId: targetId,
                attachRoom: room,
              )
            : const LoginScreen();
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
        builder = (context) => isLogged
            ? RoomDetailScreen(
                id: id ?? '',
              )
            : const LoginScreen();
        break;
      case RoomUpdateScreen.routeName:
        final id = (settings.arguments as Map<String, dynamic>)['id'];
        builder = (context) => isLogged
            ? RoomUpdateScreen(
                roomId: id ?? '',
              )
            : const LoginScreen();
        break;
      case SelectLocationScreen.routerName:
        LocationFormModel? formdata = settings.arguments as LocationFormModel;
        builder = (context) => SelectLocationScreen(input: formdata);
        break;
      case RegisterScreen.routerName:
        builder = (context) => const RegisterScreen();
        break;
      case ForgotPassword.routerName:
        builder = (context) => const ForgotPassword();
        break;
      case ResetPassword.routerName:
        final email =
            (settings.arguments as Map<String, dynamic>)['email'] as String;
        builder = (context) => ResetPassword(email: email);
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
