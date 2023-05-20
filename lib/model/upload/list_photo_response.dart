// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:roomeasy/model/file/file_info.dart';

class ListPhotoResponseModel {
  List<FileInfo> photos;
  ListPhotoResponseModel({
    required this.photos,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'photos': photos.map((x) => x.toMap()).toList(),
    };
  }

  factory ListPhotoResponseModel.fromMap(Map<String, dynamic> map) {
    return ListPhotoResponseModel(
      photos: map['photos'] != null
          ? List<FileInfo>.from(
              (map['photos'] as List<dynamic>).map<FileInfo>(
                (x) => FileInfo.fromMap(x as Map<String, dynamic>),
              ),
            )
          : [],
    );
  }
}
