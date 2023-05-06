// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:roomeasy/model/auth/profile.dart';
import 'package:roomeasy/model/common/common_key_value.dart';
import 'package:roomeasy/model/location/district.dart';
import 'package:roomeasy/model/location/province.dart';
import 'package:roomeasy/model/location/ward.dart';
import 'package:roomeasy/model/room/room_file.dart';

class RoomModel {
  String? id;
  String? name;
  String? description;
  String? address;
  AuthProfileModel? owner;
  int? rentPerMonth;
  int? deposit;
  int? squareMetre;
  ProvinceModel? province;
  DistrictModel? district;
  WardModel? ward;
  KeyValueModel? status;
  KeyValueModel? type;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<RoomFileModel>? files;
  RoomModel({
    this.id,
    this.name,
    this.description,
    this.address,
    this.owner,
    this.rentPerMonth,
    this.deposit,
    this.squareMetre,
    this.province,
    this.district,
    this.ward,
    this.status,
    this.type,
    this.createdAt,
    this.updatedAt,
    this.files,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'description': description,
      'address': address,
      'owner': owner?.toMap(),
      'rentPerMonth': rentPerMonth,
      'deposit': deposit,
      'squareMetre': squareMetre,
      'province': province?.toMap(),
      'district': district?.toMap(),
      'ward': ward?.toMap(),
      'status': status?.toMap(),
      'type': type?.toMap(),
      'createdAt': createdAt?.millisecondsSinceEpoch,
      'updatedAt': updatedAt?.millisecondsSinceEpoch,
      'files': files?.map((x) => x.toMap()).toList(),
    };
  }

  factory RoomModel.fromMap(Map<String, dynamic> map) {
    return RoomModel(
      id: map['id'] != null ? map['id'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
      description:
          map['description'] != null ? map['description'] as String : null,
      address: map['address'] != null ? map['address'] as String : null,
      owner: map['owner'] != null
          ? AuthProfileModel.fromMap(map['owner'] as Map<String, dynamic>)
          : null,
      rentPerMonth:
          map['rentPerMonth'] != null ? map['rentPerMonth'] as int : null,
      deposit: map['deposit'] != null ? map['deposit'] as int : null,
      squareMetre:
          map['squareMetre'] != null ? map['squareMetre'] as int : null,
      province: map['province'] != null
          ? ProvinceModel.fromMap(map['province'] as Map<String, dynamic>)
          : null,
      district: map['district'] != null
          ? DistrictModel.fromMap(map['district'] as Map<String, dynamic>)
          : null,
      ward: map['ward'] != null
          ? WardModel.fromMap(map['ward'] as Map<String, dynamic>)
          : null,
      status: map['status'] != null
          ? KeyValueModel.fromMap(map['status'] as Map<String, dynamic>)
          : null,
      type: map['type'] != null
          ? KeyValueModel.fromMap(map['type'] as Map<String, dynamic>)
          : null,
      createdAt: map['createdAt'] != null
          ? DateTime.parse(map['createdAt'] as String)
          : null,
      updatedAt: map['updatedAt'] != null
          ? DateTime.parse(map['updatedAt'] as String)
          : null,
      files: map['files'] != null
          ? List<RoomFileModel>.from(
              (map['files'] as List<dynamic>).map<RoomFileModel?>(
                (x) => RoomFileModel.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory RoomModel.fromJson(String source) =>
      RoomModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
