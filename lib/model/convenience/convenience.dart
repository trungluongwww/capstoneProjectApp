// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:ffi';

class ConvenienceModel {
  final String? id;
  final String? name;
  final String? code;
  final int? order;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  ConvenienceModel({
    this.id,
    this.name,
    this.code,
    this.order,
    this.createdAt,
    this.updatedAt,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'code': code,
      'order': order,
      'createdAt': createdAt?.millisecondsSinceEpoch,
      'updatedAt': updatedAt?.millisecondsSinceEpoch,
    };
  }

  factory ConvenienceModel.fromMap(Map<String, dynamic> map) {
    return ConvenienceModel(
      id: map['id'] != null ? map['id'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
      code: map['code'] != null ? map['code'] as String : null,
      order: map['order'] != null ? map['order'] as int : null,
      createdAt: map['createdAt'] != null
          ? DateTime.parse(map['createdAt'] as String)
          : null,
      updatedAt: map['updatedAt'] != null
          ? DateTime.parse(map['updatedAt'] as String)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ConvenienceModel.fromJson(String source) =>
      ConvenienceModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
