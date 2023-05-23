class UserUpdateFormModel {
  String name;
  String address;
  String provinceId;
  String districtId;
  String wardId;
  UserUpdateFormModel({
    required this.name,
    required this.address,
    required this.provinceId,
    required this.districtId,
    required this.wardId,
  });

  UserUpdateFormModel copyWith({
    String? name,
    String? address,
    String? provinceId,
    String? districtId,
    String? wardId,
  }) {
    return UserUpdateFormModel(
      name: name ?? this.name,
      address: address ?? this.address,
      provinceId: provinceId ?? this.provinceId,
      districtId: districtId ?? this.districtId,
      wardId: wardId ?? this.wardId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'address': address,
      'provinceId': provinceId,
      'districtId': districtId,
      'wardId': wardId,
    };
  }
}
