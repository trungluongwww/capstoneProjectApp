// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:roomeasy/model/message/message.dart';

class MessageResponseModel {
  final List<MessageModel> messages;
  final String pageToken;
  MessageResponseModel({
    required this.messages,
    required this.pageToken,
  });

  MessageResponseModel copyWith({
    List<MessageModel>? messages,
    String? pageToken,
  }) {
    return MessageResponseModel(
      messages: messages ?? this.messages,
      pageToken: pageToken ?? this.pageToken,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'messages': messages.map((x) => x.toMap()).toList(),
      'pageToken': pageToken,
    };
  }

  factory MessageResponseModel.fromMap(Map<String, dynamic> map) {
    return MessageResponseModel(
      messages: List<MessageModel>.from(
        (map['messages'] as List<dynamic>).map<MessageModel>(
          (x) => MessageModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
      pageToken: map['pageToken'] != null ? map['pageToken'] as String : "",
    );
  }

  String toJson() => json.encode(toMap());

  factory MessageResponseModel.fromJson(String source) =>
      MessageResponseModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
