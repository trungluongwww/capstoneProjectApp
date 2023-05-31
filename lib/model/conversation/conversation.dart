// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:roomeasy/model/auth/profile.dart';
import 'package:roomeasy/model/message/message.dart';

class ConversationModel {
  final String? id;
  final AuthProfileModel? owner;
  final AuthProfileModel? participant;
  final String? lastSenderId;
  final int? unread;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final MessageModel? lastMessage;
  ConversationModel({
    this.id,
    this.owner,
    this.participant,
    this.lastSenderId,
    this.unread,
    this.createdAt,
    this.updatedAt,
    this.lastMessage,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'owner': owner?.toMap(),
      'participant': participant?.toMap(),
      'lastSenderId': lastSenderId,
      'unread': unread,
      'createdAt': createdAt?.millisecondsSinceEpoch,
      'updatedAt': updatedAt?.millisecondsSinceEpoch,
      'lastMessage': lastMessage?.toMap(),
    };
  }

  factory ConversationModel.fromMap(Map<String, dynamic> map) {
    return ConversationModel(
      id: map['id'] != null ? map['id'] as String : null,
      owner: map['owner'] != null
          ? AuthProfileModel.fromMap(map['owner'] as Map<String, dynamic>)
          : null,
      participant: map['participant'] != null
          ? AuthProfileModel.fromMap(map['participant'] as Map<String, dynamic>)
          : null,
      lastSenderId:
          map['lastSenderId'] != null ? map['lastSenderId'] as String : null,
      unread: map['unread'] != null ? map['unread'] as int : null,
      createdAt: map['createdAt'] != null
          ? DateTime.parse(map['createdAt'] as String)
          : null,
      updatedAt: map['updatedAt'] != null
          ? DateTime.parse(map['updatedAt'] as String)
          : null,
      lastMessage: map['lastMessage'] != null
          ? MessageModel.fromMap(map['lastMessage'] as Map<String, dynamic>)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ConversationModel.fromJson(String source) =>
      ConversationModel.fromMap(json.decode(source) as Map<String, dynamic>);

  ConversationModel copyWith({
    String? id,
    AuthProfileModel? owner,
    AuthProfileModel? participant,
    String? lastSenderId,
    int? unread,
    DateTime? createdAt,
    DateTime? updatedAt,
    MessageModel? lastMessage,
  }) {
    return ConversationModel(
      id: id ?? this.id,
      owner: owner ?? this.owner,
      participant: participant ?? this.participant,
      lastSenderId: lastSenderId ?? this.lastSenderId,
      unread: unread ?? this.unread,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      lastMessage: lastMessage ?? this.lastMessage,
    );
  }
}
