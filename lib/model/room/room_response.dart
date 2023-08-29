// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:roomeasy/model/room/room.dart';

class RoomResponseModel {
  List<RoomModel>? rooms;
  int? total;
  String? pageToken;
  RoomResponseModel({
    this.rooms,
    this.total,
    this.pageToken,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'rooms': rooms?.map((x) => x.toMap()).toList(),
      'total': total,
      'pageToken': pageToken,
    };
  }

  factory RoomResponseModel.fromMap(Map<String, dynamic> map) {
    return RoomResponseModel(
      rooms: map['rooms'] != null
          ? List<RoomModel>.from(
              (map['rooms'] as List<dynamic>).map<RoomModel?>(
                (x) => RoomModel.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
      total: map['total'] != null ? map['total'] as int : null,
      pageToken: map['pageToken'] != null ? map['pageToken'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory RoomResponseModel.fromJson(String source) =>
      RoomResponseModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
