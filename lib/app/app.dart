import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:roomeasy/app/router/app_router.dart';
import 'package:roomeasy/app/screen/app_bottom_nav_bar.dart';
import 'package:roomeasy/app/screen/common/not_found.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'Inter', textTheme: const TextTheme()),
      initialRoute: AppBottomNavBar.routeName,
      onGenerateRoute: AppRouter.generateRoute,
    );
  }
}
