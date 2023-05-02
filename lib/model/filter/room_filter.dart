// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:roomeasy/model/common/common_key_value.dart';

class RoomFilterModel {
  final List<KeyValueModel>? sort;
  final List<KeyValueModel>? types;
  RoomFilterModel({
    this.sort,
    this.types,
  });

  factory RoomFilterModel.fromMap(Map<String, dynamic> map) {
    return RoomFilterModel(
      sort: map['sort'] != null
          ? List<KeyValueModel>.from(
              (map['sort'] as List<dynamic>).map<KeyValueModel?>(
                (x) => KeyValueModel.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
      types: map['types'] != null
          ? List<KeyValueModel>.from(
              (map['types'] as List<dynamic>).map<KeyValueModel?>(
                (x) => KeyValueModel.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
    );
  }

  factory RoomFilterModel.fromJson(String source) =>
      RoomFilterModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
