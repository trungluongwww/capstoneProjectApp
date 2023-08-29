// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:roomeasy/model/conversation/conversation.dart';

class ConversationResponseModel {
  final List<ConversationModel>? conversations;
  final int? total;
  final String? pageToken;
  ConversationResponseModel({
    this.conversations,
    this.total,
    this.pageToken,
  });

  ConversationResponseModel copyWith({
    List<ConversationModel>? conversations,
    int? total,
    String? pageToken,
  }) {
    return ConversationResponseModel(
      conversations: conversations ?? this.conversations,
      total: total ?? this.total,
      pageToken: pageToken ?? this.pageToken,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'conversations': conversations?.map((x) => x.toMap()).toList(),
      'total': total,
      'pageToken': pageToken,
    };
  }

  factory ConversationResponseModel.fromMap(Map<String, dynamic> map) {
    return ConversationResponseModel(
      conversations: map['conversations'] != null
          ? List<ConversationModel>.from(
              (map['conversations'] as List<dynamic>).map<ConversationModel?>(
                (x) => ConversationModel.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
      total: map['total'] != null ? map['total'] as int : null,
      pageToken: map['pageToken'] != null ? map['pageToken'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ConversationResponseModel.fromJson(String source) =>
      ConversationResponseModel.fromMap(
          json.decode(source) as Map<String, dynamic>);
}
