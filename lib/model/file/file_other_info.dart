import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class FileOtherInfo {
  String? link;
  FileOtherInfo({
    this.link,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'link': link,
    };
  }

  factory FileOtherInfo.fromMap(Map<String, dynamic> map) {
    return FileOtherInfo(
      link: map['link'] != null ? map['link'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory FileOtherInfo.fromJson(String source) =>
      FileOtherInfo.fromMap(json.decode(source) as Map<String, dynamic>);
}
