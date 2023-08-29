// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:roomeasy/model/file/file_info.dart';

class ListPhotoResponseModel {
  List<FileInfoModel> photos;
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
          ? List<FileInfoModel>.from(
              (map['photos'] as List<dynamic>).map<FileInfoModel>(
                (x) => FileInfoModel.fromMap(x as Map<String, dynamic>),
              ),
            )
          : [],
    );
  }
}
