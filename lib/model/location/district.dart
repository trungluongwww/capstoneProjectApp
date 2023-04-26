// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

@immutable
class MDistrict {
  final String id;
  final String name;
  final String code;
  final String provinceId;
  final DateTime createdAt;
  final DateTime updatedAt;

  const MDistrict({
    required this.id,
    required this.name,
    required this.code,
    required this.provinceId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory MDistrict.fromJson(Map<String, dynamic> json) {
    return MDistrict(
        id: json['id'],
        name: json['name'],
        code: json['code'],
        provinceId: json['provinceId'],
        createdAt: json['createdAt'],
        updatedAt: json['updatedAt']);
  }
}
