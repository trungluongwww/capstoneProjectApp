// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart';

@immutable
class WardModel {
  final String id;
  final String name;
  final String code;
  final String districtId;
  final DateTime createdAt;
  final DateTime updatedAt;

  const WardModel({
    required this.id,
    required this.name,
    required this.code,
    required this.districtId,
    required this.createdAt,
    required this.updatedAt,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'code': code,
      'districtId': districtId,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'updatedAt': updatedAt.millisecondsSinceEpoch,
    };
  }

  factory WardModel.fromMap(Map<String, dynamic> map) {
    return WardModel(
      id: map['id'] as String,
      name: map['name'] as String,
      code: map['code'] as String,
      districtId: map['districtId'] as String,
      createdAt: DateTime.parse(map['createdAt'] as String),
      updatedAt: DateTime.parse(map['updatedAt'] as String),
    );
  }

  String toJson() => json.encode(toMap());

  factory WardModel.fromJson(String source) =>
      WardModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

class WardResponseModel {
  final List<WardModel>? wards;
  final int? total;
  WardResponseModel({
    this.wards,
    this.total,
  });

  Map<String, dynamic> toMap() {
    if (wards == null) {
      return <String, dynamic>{'wards': null, 'total': 0};
    }
    return <String, dynamic>{
      'wards': wards!.map((x) => x.toMap()).toList(),
      'total': total,
    };
  }

  factory WardResponseModel.fromMap(Map<String, dynamic> map) {
    return WardResponseModel(
      wards: map['wards'] != null
          ? List<WardModel>.from(
              (map['wards'] as List<dynamic>).map<WardModel?>(
                (x) => WardModel.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
      total: map['total'] != null ? map['total'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory WardResponseModel.fromJson(String source) =>
      WardResponseModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
