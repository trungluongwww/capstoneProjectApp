// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:roomeasy/model/location/district.dart';
import 'package:roomeasy/model/location/province.dart';
import 'package:roomeasy/model/location/ward.dart';

class MAuthProfile {
  String id;
  String username;
  String phone;
  String email;
  String zalo;
  String facebook;
  String name;
  String avatar;
  DateTime createdAt;
  DateTime updatedAt;
  String address;
  bool root;
  ProvinceModel province;
  DistrictModel district;
  WardModel ward;
  MAuthProfile({
    required this.id,
    required this.username,
    required this.phone,
    required this.email,
    required this.zalo,
    required this.facebook,
    required this.name,
    required this.avatar,
    required this.createdAt,
    required this.updatedAt,
    required this.address,
    required this.root,
    required this.province,
    required this.district,
    required this.ward,
  });

  factory MAuthProfile.fromMap(Map<String, dynamic> map) {
    return MAuthProfile(
      id: map['id'] as String,
      username: map['username'] as String,
      phone: map['phone'] as String,
      email: map['email'] as String,
      zalo: map['zalo'] as String,
      facebook: map['facebook'] as String,
      name: map['name'] as String,
      avatar: map['avatar'] as String,
      createdAt: map['createdAt'],
      updatedAt: map['updatedAt'],
      address: map['address'] as String,
      root: map['root'] as bool,
      province: ProvinceModel.fromJson(map['province']),
      district: DistrictModel.fromJson(map['district']),
      ward: WardModel.fromJson(map['ward']),
    );
  }
}
