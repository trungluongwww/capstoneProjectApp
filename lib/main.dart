import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:roomeasy/app/app.dart';
import 'package:roomeasy/network/connection.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  ConnectionNetwork instance = ConnectionNetwork.getInstance();
  instance.init();

  runApp(const ProviderScope(
    observers: [],
    child: App(),
  ));
}
