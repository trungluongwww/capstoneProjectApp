import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class FileFormModel {
  final String? name;
  final String? originName;
  final String? width;
  final String? height;
  final String? type;
  final String? url;
  FileFormModel({
    this.name,
    this.originName,
    this.width,
    this.height,
    this.type,
    this.url,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'originName': originName,
      'width': width,
      'height': height,
      'type': type,
      'url': url,
    };
  }
}
