import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class ProvinceModel {
  final String id;
  final String name;
  final String code;
  final DateTime createdAt;
  final DateTime updatedAt;

  const ProvinceModel({
    required this.id,
    required this.name,
    required this.code,
    required this.createdAt,
    required this.updatedAt,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'code': code,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'updatedAt': updatedAt.millisecondsSinceEpoch,
    };
  }

  factory ProvinceModel.fromMap(Map<String, dynamic> map) {
    return ProvinceModel(
      id: map['id'] as String,
      name: map['name'] as String,
      code: map['code'] as String,
      createdAt: DateTime.parse(map['createdAt'] as String),
      updatedAt: DateTime.parse(map['updatedAt'] as String),
    );
  }

  String toJson() => json.encode(toMap());

  factory ProvinceModel.fromJson(String source) =>
      ProvinceModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

// response
class ProvinceResponseModel {
  final List<ProvinceModel>? provinces;
  final int? total;

  ProvinceResponseModel({
    this.provinces,
    this.total,
  });

  Map<String, dynamic> toMap() {
    if (provinces == null) {
      return <String, dynamic>{'provinces': null, 'total': 0};
    }

    return <String, dynamic>{
      'provinces': provinces!.map((x) => x.toMap()).toList(),
      'total': total,
    };
  }

  factory ProvinceResponseModel.fromMap(Map<String, dynamic> map) {
    return ProvinceResponseModel(
      provinces: map['provinces'] != null
          ? List<ProvinceModel>.from(
              (map['provinces'] as List<dynamic>).map<ProvinceModel?>(
                (x) => ProvinceModel.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
      total: map['total'] != null ? map['total'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProvinceResponseModel.fromJson(String source) =>
      ProvinceResponseModel.fromMap(
          json.decode(source) as Map<String, dynamic>);
}
