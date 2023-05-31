// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:roomeasy/model/file/file_info.dart';
import 'package:roomeasy/model/room/room.dart';

class MessageModel {
  final String? id;
  final String? authorId;
  final String? content;
  final String? type;
  final FileInfoModel? file;
  final RoomModel? room;
  final String? conversationId;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  MessageModel({
    this.id,
    this.authorId,
    this.content,
    this.type,
    this.file,
    this.room,
    this.conversationId,
    this.createdAt,
    this.updatedAt,
  });

  MessageModel copyWith({
    String? id,
    String? authorId,
    String? content,
    String? type,
    FileInfoModel? file,
    RoomModel? room,
    String? conversationId,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return MessageModel(
      id: id ?? this.id,
      authorId: authorId ?? this.authorId,
      content: content ?? this.content,
      type: type ?? this.type,
      file: file ?? this.file,
      room: room ?? this.room,
      conversationId: conversationId ?? this.conversationId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'authorId': authorId,
      'content': content,
      'type': type,
      'file': file?.toMap(),
      'room': room?.toMap(),
      'conversationId': conversationId,
      'createdAt': createdAt?.millisecondsSinceEpoch,
      'updatedAt': updatedAt?.millisecondsSinceEpoch,
    };
  }

  factory MessageModel.fromMap(Map<String, dynamic> map) {
    return MessageModel(
      id: map['id'] != null ? map['id'] as String : null,
      authorId: map['authorId'] != null ? map['authorId'] as String : null,
      content: map['content'] != null ? map['content'] as String : null,
      type: map['type'] != null ? map['type'] as String : null,
      file: map['file'] != null
          ? FileInfoModel.fromMap(map['file'] as Map<String, dynamic>)
          : null,
      room: map['room'] != null
          ? RoomModel.fromMap(map['room'] as Map<String, dynamic>)
          : null,
      conversationId: map['conversationId'] != null
          ? map['conversationId'] as String
          : null,
      createdAt: map['createdAt'] != null
          ? DateTime.parse(map['createdAt'] as String)
          : null,
      updatedAt: map['updatedAt'] != null
          ? DateTime.parse(map['updatedAt'] as String)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory MessageModel.fromJson(String source) =>
      MessageModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
