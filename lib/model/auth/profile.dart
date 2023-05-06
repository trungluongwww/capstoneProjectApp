// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:roomeasy/model/location/district.dart';
import 'package:roomeasy/model/location/province.dart';
import 'package:roomeasy/model/location/ward.dart';

class AuthProfileModel {
  String? id;
  String? username;
  String? phone;
  String? email;
  String? zalo;
  String? facebook;
  String? name;
  String? avatar;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? address;
  bool? root;
  ProvinceModel? province;
  DistrictModel? district;
  WardModel? ward;
  AuthProfileModel({
    this.id,
    this.username,
    this.phone,
    this.email,
    this.zalo,
    this.facebook,
    this.name,
    this.avatar,
    this.createdAt,
    this.updatedAt,
    this.address,
    this.root,
    this.province,
    this.district,
    this.ward,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'username': username,
      'phone': phone,
      'email': email,
      'zalo': zalo,
      'facebook': facebook,
      'name': name,
      'avatar': avatar,
      'createdAt': createdAt?.millisecondsSinceEpoch,
      'updatedAt': updatedAt?.millisecondsSinceEpoch,
      'address': address,
      'root': root,
      'province': province?.toMap(),
      'district': district?.toMap(),
      'ward': ward?.toMap(),
    };
  }

  factory AuthProfileModel.fromMap(Map<String, dynamic> map) {
    return AuthProfileModel(
      id: map['id'] != null ? map['id'] as String : null,
      username: map['username'] != null ? map['username'] as String : null,
      phone: map['phone'] != null ? map['phone'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      zalo: map['zalo'] != null ? map['zalo'] as String : null,
      facebook: map['facebook'] != null ? map['facebook'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
      avatar: map['avatar'] != null ? map['avatar'] as String : null,
      createdAt: map['createdAt'] != null
          ? DateTime.parse(map['createdAt'] as String)
          : null,
      updatedAt: map['updatedAt'] != null
          ? DateTime.parse(map['updatedAt'] as String)
          : null,
      address: map['address'] != null ? map['address'] as String : null,
      root: map['root'] != null ? map['root'] as bool : null,
      province: map['province'] != null
          ? ProvinceModel.fromMap(map['province'] as Map<String, dynamic>)
          : null,
      district: map['district'] != null
          ? DistrictModel.fromMap(map['district'] as Map<String, dynamic>)
          : null,
      ward: map['ward'] != null
          ? WardModel.fromMap(map['ward'] as Map<String, dynamic>)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory AuthProfileModel.fromJson(String source) =>
      AuthProfileModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
