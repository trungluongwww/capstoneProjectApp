// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:roomeasy/model/file/file_other_info.dart';
import 'package:roomeasy/model/file/file_thumbnail_info.dart';

class FileInfoModel {
  String? name;
  String? originName;
  int? width;
  int? height;
  String? type;
  String? url;
  FileOtherInfo? others;
  FileThumbnailInfo? thumbnail;
  FileInfoModel({
    this.name,
    this.originName,
    this.width,
    this.height,
    this.type,
    this.url,
    this.others,
    this.thumbnail,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'originName': originName,
      'width': width,
      'height': height,
      'type': type,
      'url': url,
      'others': others?.toMap(),
      'thumbnail': thumbnail?.toMap(),
    };
  }

  factory FileInfoModel.fromMap(Map<String, dynamic> map) {
    return FileInfoModel(
      name: map['name'] != null ? map['name'] as String : null,
      originName:
          map['originName'] != null ? map['originName'] as String : null,
      width: map['width'] != null ? map['width'] as int : null,
      height: map['height'] != null ? map['height'] as int : null,
      type: map['type'] != null ? map['type'] as String : null,
      url: map['url'] != null ? map['url'] as String : null,
      others: map['others'] != null
          ? FileOtherInfo.fromMap(map['others'] as Map<String, dynamic>)
          : null,
      thumbnail: map['thumbnail'] != null
          ? FileThumbnailInfo.fromMap(map['thumbnail'] as Map<String, dynamic>)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory FileInfoModel.fromJson(String source) =>
      FileInfoModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
