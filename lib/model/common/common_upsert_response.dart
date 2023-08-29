import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class CommonUpsertResponseModel {
  final String id;

  CommonUpsertResponseModel({
    required this.id,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
    };
  }

  factory CommonUpsertResponseModel.fromMap(Map<String, dynamic> map) {
    return CommonUpsertResponseModel(
      id: map['id'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory CommonUpsertResponseModel.fromJson(String source) =>
      CommonUpsertResponseModel.fromMap(
          json.decode(source) as Map<String, dynamic>);
}
