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
  MProvince province;
  MDistrict district;
  MWard ward;
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

  factory MAuthProfile.fromJson(Map<String, dynamic> json) {
    return MAuthProfile(
      id: json['id'] as String,
      username: json['username'] as String,
      phone: json['phone'] as String,
      email: json['email'] as String,
      zalo: json['zalo'] as String,
      facebook: json['facebook'] as String,
      name: json['name'] as String,
      avatar: json['avatar'] as String,
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      address: json['address'] as String,
      root: json['root'] as bool,
      province: MProvince.fromJson(json['province']),
      district: MDistrict.fromJson(json['district']),
      ward: MWard.fromJson(json['ward']),
    );
  }
}
