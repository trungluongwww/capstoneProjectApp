// ignore_for_file: public_member_api_docs, sort_constructors_first
class LocationFormModel {
  String? provinceId;
  String? provinceName;
  String? districtId;
  String? districtName;
  String? wardId;
  String? wardName;
  LocationFormModel({
    this.provinceId,
    this.provinceName,
    this.districtId,
    this.districtName,
    this.wardId,
    this.wardName,
  });

  LocationFormModel copyWith({
    String? provinceId,
    String? provinceName,
    String? districtId,
    String? districtName,
    String? wardId,
    String? wardName,
  }) {
    return LocationFormModel(
      provinceId: provinceId ?? this.provinceId,
      provinceName: provinceName ?? this.provinceName,
      districtId: districtId ?? this.districtId,
      districtName: districtName ?? this.districtName,
      wardId: wardId ?? this.wardId,
      wardName: wardName ?? this.wardName,
    );
  }

  bool isValid() {
    return districtId != null && provinceId != null && wardId != null;
  }

  factory LocationFormModel.fromData(dynamic data) {
    try {
      return data as LocationFormModel;
    } catch (e) {
      return LocationFormModel();
    }
  }

  @override
  String toString() {
    if (provinceName == null) return "";

    List<String> names = [];

    if (provinceName != null) names.add('Tp.${provinceName!}');

    if (districtName != null) names.add('Q.${districtName!}');

    if (wardName != null) names.add('P.${wardName!}');

    return names.join(', ');
  }
}
