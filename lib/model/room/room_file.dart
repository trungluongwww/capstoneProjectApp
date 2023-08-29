// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:roomeasy/model/file/file_info.dart';

class RoomFileModel {
  String? id;
  FileInfoModel? info;
  DateTime? createdAt;
  RoomFileModel({
    this.id,
    this.info,
    this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'info': info?.toMap(),
      'createdAt': createdAt?.millisecondsSinceEpoch,
    };
  }

  factory RoomFileModel.fromMap(Map<String, dynamic> map) {
    return RoomFileModel(
      id: map['id'] != null ? map['id'] as String : null,
      info: map['info'] != null
          ? FileInfoModel.fromMap(map['info'] as Map<String, dynamic>)
          : null,
      createdAt: map['createdAt'] != null
          ? DateTime.parse(map['createdAt'] as String)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory RoomFileModel.fromJson(String source) =>
      RoomFileModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
