import 'dart:io';

import 'package:flutter/material.dart';
import 'package:roomeasy/api/services/base/base.dart';
import 'package:roomeasy/api/constant/constant.dart';
import 'package:http/http.dart' as http;
import 'package:roomeasy/model/file/file_info.dart';
import 'package:roomeasy/model/response/response.dart';
import 'package:roomeasy/model/upload/list_photo_response.dart';

class UploadService extends BaseService {
  UploadService() : super();

  Future<ResponseModel<ListPhotoResponseModel>> uploadPhotos(
      List<File> files) async {
    try {
      var uri = Apiconstants.getUri(
          "${Apiconstants.apiVersion}${Apiconstants.uploadEndpoint}/multiple-photo",
          null);

      var request = http.MultipartRequest(
        'POST',
        uri,
      );

      for (final f in files) {
        request.files.add(http.MultipartFile.fromBytes(
            'files', await f.readAsBytes(),
            filename: f.path.split('/').last));
      }

      final res = await postFormData(request);

      return ResponseModel<ListPhotoResponseModel>(
          code: res.code,
          data: res.data != null
              ? ListPhotoResponseModel.fromMap(res.data!)
              : null,
          message: res.message);
    } catch (e) {
      debugPrint("Error in api.service.upload.uploadPhotos: ${e.toString()}");
      return ResponseModel<ListPhotoResponseModel>(
        code: 500,
        message: e.toString(),
        data: null,
      );
    }
  }

  Future<ResponseModel<FileInfoModel>> uploadAvatar(File file) async {
    try {
      var uri = Apiconstants.getUri(
          "${Apiconstants.apiVersion}${Apiconstants.uploadEndpoint}/avatar",
          null);

      var request = http.MultipartRequest(
        'POST',
        uri,
      );

      request.files.add(http.MultipartFile.fromBytes(
          'file', await file.readAsBytes(),
          filename: file.path.split('/').last));

      final res = await postFormData(request);

      return ResponseModel<FileInfoModel>(
          code: res.code,
          data: res.data != null ? FileInfoModel.fromMap(res.data!) : null,
          message: res.message);
    } catch (e) {
      debugPrint("Error in api.service.upload.uploadAvatar: ${e.toString()}");
      return ResponseModel<FileInfoModel>(
        code: 500,
        message: e.toString(),
        data: null,
      );
    }
  }

  Future<ResponseModel<FileInfoModel>> uploadSinglePhoto(File file) async {
    try {
      var uri = Apiconstants.getUri(
          "${Apiconstants.apiVersion}${Apiconstants.uploadEndpoint}/single-photo",
          null);

      var request = http.MultipartRequest(
        'POST',
        uri,
      );

      request.files.add(http.MultipartFile.fromBytes(
          'file', await file.readAsBytes(),
          filename: file.path.split('/').last));

      final res = await postFormData(request);

      return ResponseModel<FileInfoModel>(
          code: res.code,
          data: res.data != null ? FileInfoModel.fromMap(res.data!) : null,
          message: res.message);
    } catch (e) {
      debugPrint(
          "Error in api.service.upload.uploadSinglePhoto: ${e.toString()}");
      return ResponseModel<FileInfoModel>(
        code: 500,
        message: e.toString(),
        data: null,
      );
    }
  }
}
