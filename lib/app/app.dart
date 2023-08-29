import 'package:flutter/material.dart';
import 'package:roomeasy/app/constant/app_color.dart';
import 'package:roomeasy/app/router/router.dart';
import 'package:roomeasy/app/screen/home/home.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'Inter',
        textTheme: const TextTheme(
            titleSmall: TextStyle(
                color: AppColor.appTextDefaultColor,
                fontWeight: FontWeight.w700,
                fontSize: 10),
            titleMedium: TextStyle(
                color: AppColor.appTextDefaultColor,
                fontWeight: FontWeight.w700,
                fontSize: 14),
            titleLarge: TextStyle(
                color: AppColor.appTextDefaultColor,
                fontWeight: FontWeight.w700,
                fontSize: 24),
            bodySmall: TextStyle(
                color: AppColor.appTextDefaultColor,
                fontWeight: FontWeight.w400,
                fontSize: 10),
            bodyMedium: TextStyle(
                color: AppColor.appTextDefaultColor,
                fontWeight: FontWeight.w400,
                fontSize: 12),
            bodyLarge: TextStyle(
                color: AppColor.appTextDefaultColor,
                fontWeight: FontWeight.w400,
                fontSize: 18)),
      ),
      initialRoute: Home.routeName,
      onGenerateRoute: AppRouter.generateRoute,
    );
  }
}
