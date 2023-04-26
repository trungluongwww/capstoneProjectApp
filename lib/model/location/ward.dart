import 'package:flutter/material.dart';

@immutable
class MWard {
  final String id;
  final String name;
  final String code;
  final String districtId;
  final DateTime createdAt;
  final DateTime updatedAt;

  const MWard({
    required this.id,
    required this.name,
    required this.code,
    required this.districtId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory MWard.fromJson(Map<String, dynamic> json) {
    return MWard(
        id: json['id'],
        name: json['name'],
        code: json['code'],
        districtId: json['districtId'],
        createdAt: json['createdAt'],
        updatedAt: json['updatedAt']);
  }
}
