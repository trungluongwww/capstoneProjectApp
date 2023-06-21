import 'dart:async';
import 'package:roomeasy/api/constant/constant.dart';
import 'package:roomeasy/model/message/message.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

class SocketManager {
  SocketManager();

  // event name
  final String eventNewMessage = "message.new";
  final String eventConversationSeen = "conversation.seen";

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

  static io.Socket? _socket;

  late StreamController<MessageModel> _streamControllerNewMessage;
  Stream<MessageModel> get streamNewMessage =>
      _streamControllerNewMessage.stream;

  Future<void> connect() async {
    // connect
    if (_socket != null) {
      _socket?.connect();
    } else {
      _socket = io.io(Apiconstants.getSocketURI(), <String, dynamic>{
        'transports': ['websocket'],
        'extraHeaders': await _getHeader(),
      });
    }

    _streamControllerNewMessage = StreamController<MessageModel>.broadcast();

    _socket?.on(eventNewMessage, (data) {
      MessageModel msg = MessageModel.fromMap(data);
      _streamControllerNewMessage.add(msg);
    });
  }

  void emitConversationSeen(String conversationId) {
    _socket?.emit(eventConversationSeen, {"conversationId": conversationId});
  }

  void disconnect() {
    _socket?.disconnect();
    _socket?.dispose();
  }
}
