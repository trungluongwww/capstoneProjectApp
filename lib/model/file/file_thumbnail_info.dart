import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class FileThumbnailInfo {
  String? name;
  String? originName;
  int? width;
  int? height;
  String? url;
  FileThumbnailInfo({
    this.name,
    this.originName,
    this.width,
    this.height,
    this.url,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'originName': originName,
      'width': width,
      'height': height,
      'url': url,
    };
  }

  factory FileThumbnailInfo.fromMap(Map<String, dynamic> map) {
    return FileThumbnailInfo(
      name: map['name'] != null ? map['name'] as String : null,
      originName:
          map['originName'] != null ? map['originName'] as String : null,
      width: map['width'] != null ? map['width'] as int : null,
      height: map['height'] != null ? map['height'] as int : null,
      url: map['url'] != null ? map['url'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory FileThumbnailInfo.fromJson(String source) =>
      FileThumbnailInfo.fromMap(json.decode(source) as Map<String, dynamic>);
}
