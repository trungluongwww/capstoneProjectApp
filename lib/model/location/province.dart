class MProvince {
  final String id;
  final String name;
  final String code;
  final DateTime createdAt;
  final DateTime updatedAt;

  const MProvince({
    required this.id,
    required this.name,
    required this.code,
    required this.createdAt,
    required this.updatedAt,
  });

  factory MProvince.fromJson(Map<String, dynamic> json) {
    return MProvince(
        id: json['id'],
        name: json['name'],
        code: json['code'],
        createdAt: json['createdAt'],
        updatedAt: json['updatedAt']);
  }
}
