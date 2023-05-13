class RegisterFormModel {
  final String email;
  final String password;
  final String phone;
  final String name;
  final String provinceId;
  final String districtId;
  final String wardId;
  final String address;
  RegisterFormModel({
    required this.email,
    required this.password,
    required this.phone,
    required this.name,
    required this.provinceId,
    required this.districtId,
    required this.wardId,
    required this.address,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
      'password': password,
      'phone': phone,
      'name': name,
      'provinceId': provinceId,
      'districtId': districtId,
      'wardId': wardId,
      'address': address,
    };
  }
}
