// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart';

@immutable
class DistrictModel {
  final String id;
  final String name;
  final String code;
  final String provinceId;
  final DateTime createdAt;
  final DateTime updatedAt;

  const DistrictModel({
    required this.id,
    required this.name,
    required this.code,
    required this.provinceId,
    required this.createdAt,
    required this.updatedAt,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'code': code,
      'provinceId': provinceId,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'updatedAt': updatedAt.millisecondsSinceEpoch,
    };
  }

  factory DistrictModel.fromMap(Map<String, dynamic> map) {
    return DistrictModel(
      id: map['id'] as String,
      name: map['name'] as String,
      code: map['code'] as String,
      provinceId: map['provinceId'] as String,
      createdAt: DateTime.parse(map['createdAt'] as String),
      updatedAt: DateTime.parse(map['updatedAt'] as String),
    );
  }

  String toJson() => json.encode(toMap());

  factory DistrictModel.fromJson(String source) =>
      DistrictModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

class DistrictResponseModel {
  final List<DistrictModel>? districts;
  final int? total;
  DistrictResponseModel({
    this.districts,
    this.total,
  });

  Map<String, dynamic> toMap() {
    if (districts == null) {
      return <String, dynamic>{'districts': null, 'total': 0};
    }
    return <String, dynamic>{
      'districts': districts!.map((x) => x.toMap()).toList(),
      'total': total,
    };
  }

  factory DistrictResponseModel.fromMap(Map<String, dynamic> map) {
    return DistrictResponseModel(
      districts: map['districts'] != null
          ? List<DistrictModel>.from(
              (map['districts'] as List<dynamic>).map<DistrictModel?>(
                (x) => DistrictModel.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
      total: map['total'] != null ? map['total'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory DistrictResponseModel.fromJson(String source) =>
      DistrictResponseModel.fromMap(
          json.decode(source) as Map<String, dynamic>);
}
