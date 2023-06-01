import 'dart:async';

import 'package:flutter/material.dart';
import 'package:roomeasy/api/constant/constant.dart';
import 'package:roomeasy/model/message/message.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketManager {
  SocketManager();

  // event name
  final String eventNewMessage = "message.new";

  Future<Map<String, String>> _getHeader() async {
    var token = await _getToken();
    return {
      'Authorization': 'Bearer ${token ?? ""}',
    };
  }

  Future<String?> _getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(Apiconstants.authToken);
  }

  static IO.Socket? _socket;

  late StreamController<MessageModel> _streamControllerNewMessage;
  Stream<MessageModel> get streamNewMessage =>
      _streamControllerNewMessage.stream;

  Future<void> connect() async {
    // connect
    if (_socket != null) {
      _socket?.connect();
    } else {
      _socket = IO.io('http://${Apiconstants.getBaseURL()}', <String, dynamic>{
        'transports': ['websocket'],
        'extraHeaders': await _getHeader(),
      });
    }

    _socket?.on('connect', (_) {
      print('Connected');
    });

    _socket?.on('disconnect', (_) {
      print('Disconnected');
    });

    _socket?.onConnectError((err) => print(err));

    _streamControllerNewMessage = StreamController<MessageModel>.broadcast();

    _socket?.on(eventNewMessage, (data) {
      MessageModel msg = MessageModel.fromMap(data);
      _streamControllerNewMessage.add(msg);
    });
  }

  void disconnect() {
    _streamControllerNewMessage.close();
    _socket?.disconnect();
    _socket?.dispose();
  }
}
