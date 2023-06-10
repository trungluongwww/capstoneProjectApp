import 'dart:async';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectionNetwork {
  ConnectionNetwork._internal();
  static final ConnectionNetwork _instance = ConnectionNetwork._internal();
  static ConnectionNetwork getInstance() => _instance;

  final _connectivity = Connectivity();
  final _controller = StreamController<bool>.broadcast();
  Stream<bool> get streamNetwork => _controller.stream;

  void init() async {
    try {
      _connectivity.onConnectivityChanged.listen((event) {
        _checkConnection(event);
      });
    } catch (e) {
      _controller.add(false);
    }
  }

  void dispose() {
    _controller.close();
  }

  void _checkConnection(ConnectivityResult event) async {
    try {
      final res = await InternetAddress.lookup('www.google.com');
      if (res.isNotEmpty && res[0].rawAddress.isNotEmpty) {
        _controller.add(true);
      } else {
        _controller.add(false);
      }
    } on SocketException catch (_) {
      _controller.add(false);
    }
  }
}
