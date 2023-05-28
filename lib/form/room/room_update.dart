import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class RoomUpdateFormModel {
  String name;
  String description;
  int rentPerMonth;
  int deposit;
  int squareMetre;
  String provinceId;
  String districtId;
  String wardId;
  String address;
  String type;

  RoomUpdateFormModel({
    required this.name,
    required this.description,
    required this.rentPerMonth,
    required this.deposit,
    required this.squareMetre,
    required this.provinceId,
    required this.districtId,
    required this.wardId,
    required this.address,
    required this.type,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'description': description,
      'rentPerMonth': rentPerMonth,
      'deposit': deposit,
      'squareMetre': squareMetre,
      'provinceId': provinceId,
      'districtId': districtId,
      'wardId': wardId,
      'address': address,
      'type': type,
    };
  }

  factory RoomUpdateFormModel.fromMap(Map<String, dynamic> map) {
    return RoomUpdateFormModel(
      name: map['name'] as String,
      description: map['description'] as String,
      rentPerMonth: map['rentPerMonth'] as int,
      deposit: map['deposit'] as int,
      squareMetre: map['squareMetre'] as int,
      provinceId: map['provinceId'] as String,
      districtId: map['districtId'] as String,
      wardId: map['wardId'] as String,
      address: map['address'] as String,
      type: map['type'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory RoomUpdateFormModel.fromJson(String source) =>
      RoomUpdateFormModel.fromMap(json.decode(source) as Map<String, dynamic>);

  RoomUpdateFormModel copyWith({
    String? name,
    String? description,
    int? rentPerMonth,
    int? deposit,
    int? squareMetre,
    String? provinceId,
    String? districtId,
    String? wardId,
    String? address,
    String? type,
  }) {
    return RoomUpdateFormModel(
      name: name ?? this.name,
      description: description ?? this.description,
      rentPerMonth: rentPerMonth ?? this.rentPerMonth,
      deposit: deposit ?? this.deposit,
      squareMetre: squareMetre ?? this.squareMetre,
      provinceId: provinceId ?? this.provinceId,
      districtId: districtId ?? this.districtId,
      wardId: wardId ?? this.wardId,
      address: address ?? this.address,
      type: type ?? this.type,
    );
  }
}
