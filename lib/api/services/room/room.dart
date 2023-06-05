import 'package:flutter/material.dart';
import 'package:roomeasy/api/constant/constant.dart';
import 'package:roomeasy/api/services/base/base.dart';
import 'package:roomeasy/form/file/file.dart';
import 'package:roomeasy/form/room/room_change_status.dart';
import 'package:roomeasy/form/room/room_create.dart';
import 'package:roomeasy/form/room/room_remove_photo.dart';
import 'package:roomeasy/form/room/room_update.dart';
import 'package:roomeasy/model/common/common_upsert_response.dart';
import 'package:roomeasy/model/filter/room_filter.dart';
import 'package:roomeasy/model/response/response.dart';
import 'package:roomeasy/model/room/room.dart';
import 'package:roomeasy/model/room/room_response.dart';

class RoomServices extends BaseService {
  RoomServices() : super();

  Future<ResponseModel<RoomFilterModel>> getFilters() async {
    try {
      final url = Uri.http(Apiconstants.getBaseURL(),
          "${Apiconstants.apiVersion}${Apiconstants.filterEndpoint}");

      var response = await get(uri: url);

      if (!response.code.toString().startsWith('2')) {
        debugPrint(
            "[APIService] ${url.toString()} code:${response.code} message:${response.message}");
      }

      return ResponseModel<RoomFilterModel>(
        code: response.code,
        message: response.message,
        data: response.data != null
            ? RoomFilterModel.fromMap(response.data!['room'])
            : null,
      );
    } catch (e) {
      debugPrint("Error in api.service.room.getFilter: ${e.toString()}");
      return ResponseModel<RoomFilterModel>(
        code: 500,
        message: e.toString(),
        data: null,
      );
    }
  }

  Future<ResponseModel<RoomResponseModel>> getRooms({
    String? orderField,
    String? orderValue,
    String? provinceId,
    String? districtId,
    String? wardId,
    String? keyword,
    String? pageToken,
    String? type,
  }) async {
    Map<String, dynamic> params = {
      'provinceId': provinceId,
      'districtId': districtId,
      'wardId': wardId,
      'pageToken': pageToken,
      'keyword': keyword,
      'orderField': orderField,
      'orderValue': orderValue,
      'type': type,
    };

    if (orderValue == null || orderField == null) {
      params.remove('orderValue');
      params.remove('orderField');
    }

    if (type == null) {
      params.remove('type');
    }

    try {
      final url = Uri.http(Apiconstants.getBaseURL(),
          "${Apiconstants.apiVersion}${Apiconstants.roomEndpoint}", params);

      var response = await get(uri: url);
      if (!response.code.toString().startsWith('2')) {
        debugPrint(
            "[APIService] ${url.toString()} code:${response.code} message:${response.message}");
      }
      return ResponseModel<RoomResponseModel>(
        code: response.code,
        message: response.message,
        data: response.data != null
            ? RoomResponseModel.fromMap(response.data!)
            : null,
      );
    } catch (e) {
      debugPrint("Error in api.service.room.getRooms: ${e.toString()}");
      return ResponseModel<RoomResponseModel>(
        code: 500,
        message: e.toString(),
        data: null,
      );
    }
  }

  Future<ResponseModel<RoomModel>> getDetailRoom({
    required String id,
  }) async {
    try {
      final url = Uri.http(Apiconstants.getBaseURL(),
          "${Apiconstants.apiVersion}${Apiconstants.roomEndpoint}/$id");

      var response = await get(uri: url);
      if (!response.code.toString().startsWith('2')) {
        debugPrint(
            "[APIService] ${url.toString()} code:${response.code} message:${response.message}");
      }
      return ResponseModel<RoomModel>(
        code: response.code,
        message: response.message,
        data: response.data != null
            ? RoomModel.fromMap(response.data!['room'])
            : null,
      );
    } catch (e) {
      debugPrint("Error in api.service.room.getDetailRoom: ${e.toString()}");
      return ResponseModel<RoomModel>(
        code: 500,
        message: e.toString(),
        data: null,
      );
    }
  }

  Future<ResponseModel<RoomModel>> create({
    required RoomCreateFormModel formdata,
  }) async {
    try {
      final url = Uri.http(Apiconstants.getBaseURL(),
          "${Apiconstants.apiVersion}${Apiconstants.roomEndpoint}");

      var response = await post(uri: url, body: formdata.toMap());
      if (!response.code.toString().startsWith('2')) {
        debugPrint(
            "[APIService] ${url.toString()} code:${response.code} message:${response.message}");
      }
      return ResponseModel<RoomModel>(
          code: response.code, message: response.message, data: null);
    } catch (e) {
      debugPrint("Error in api.service.room.create: ${e.toString()}");
      return ResponseModel<RoomModel>(
        code: 500,
        message: e.toString(),
        data: null,
      );
    }
  }

  Future<ResponseModel<RoomModel>> update({
    required String id,
    required RoomUpdateFormModel formdata,
  }) async {
    try {
      final url = Uri.http(Apiconstants.getBaseURL(),
          "${Apiconstants.apiVersion}${Apiconstants.roomEndpoint}/$id");

      var response = await put(uri: url, body: formdata.toMap());
      if (!response.code.toString().startsWith('2')) {
        debugPrint(
            "[APIService] ${url.toString()} code:${response.code} message:${response.message}");
      }
      return ResponseModel<RoomModel>(
          code: response.code, message: response.message, data: null);
    } catch (e) {
      debugPrint("Error in api.service.room.update: ${e.toString()}");
      return ResponseModel<RoomModel>(
        code: 500,
        message: e.toString(),
        data: null,
      );
    }
  }

  Future<ResponseModel<CommonUpsertResponseModel>> addPhoto({
    required String roomId,
    required FileFormModel formdata,
  }) async {
    try {
      final url = Uri.http(Apiconstants.getBaseURL(),
          "${Apiconstants.apiVersion}${Apiconstants.roomEndpoint}/$roomId/photo");

      var response = await post(uri: url, body: formdata.toMap());
      if (!response.code.toString().startsWith('2')) {
        debugPrint(
            "[APIService] ${url.toString()} code:${response.code} message:${response.message}");
      }
      return ResponseModel<CommonUpsertResponseModel>(
          code: response.code,
          message: response.message,
          data: response.data != null
              ? CommonUpsertResponseModel.fromMap(response.data!)
              : null);
    } catch (e) {
      debugPrint("Error in api.service.room.addPhoto: ${e.toString()}");
      return ResponseModel<CommonUpsertResponseModel>(
        code: 500,
        message: e.toString(),
        data: null,
      );
    }
  }

  Future<ResponseModel<CommonUpsertResponseModel>> removePhoto({
    required String roomId,
    required RoomRemovePhotoFormModel formdata,
  }) async {
    try {
      final url = Uri.http(Apiconstants.getBaseURL(),
          "${Apiconstants.apiVersion}${Apiconstants.roomEndpoint}/$roomId/photo");
      var response = await delete(uri: url, body: formdata.toMap());

      if (!response.code.toString().startsWith('2')) {
        debugPrint(
            "[APIService] ${url.toString()} code:${response.code} message:${response.message}");
      }

      return ResponseModel<CommonUpsertResponseModel>(
          code: response.code, message: response.message, data: null);
    } catch (e) {
      debugPrint("Error in api.service.room.addPhoto: ${e.toString()}");
      return ResponseModel<CommonUpsertResponseModel>(
        code: 500,
        message: e.toString(),
        data: null,
      );
    }
  }

  Future<ResponseModel<CommonUpsertResponseModel>> changeStatus({
    required String roomId,
    required RoomChangeStatusFormModel formdata,
  }) async {
    try {
      final url = Uri.http(Apiconstants.getBaseURL(),
          "${Apiconstants.apiVersion}${Apiconstants.roomEndpoint}/$roomId/status");
      var response = await patch(uri: url, body: formdata.toMap());

      if (!response.code.toString().startsWith('2')) {
        debugPrint(
            "[APIService] ${url.toString()} code:${response.code} message:${response.message}");
      }

      return ResponseModel<CommonUpsertResponseModel>(
          code: response.code, message: response.message, data: null);
    } catch (e) {
      debugPrint("Error in api.service.room.changeStatus: ${e.toString()}");
      return ResponseModel<CommonUpsertResponseModel>(
        code: 500,
        message: e.toString(),
        data: null,
      );
    }
  }

  Future<ResponseModel<RoomResponseModel>> getRecommends() async {
    try {
      final url = Uri.http(
        Apiconstants.getBaseURL(),
        "${Apiconstants.apiVersion}${Apiconstants.roomEndpoint}/recommends",
      );

      var response = await get(uri: url);
      if (!response.code.toString().startsWith('2')) {
        debugPrint(
            "[APIService] ${url.toString()} code:${response.code} message:${response.message}");
      }
      return ResponseModel<RoomResponseModel>(
        code: response.code,
        message: response.message,
        data: response.data != null
            ? RoomResponseModel.fromMap(response.data!)
            : null,
      );
    } catch (e) {
      debugPrint("Error in api.service.auth.getRecommends: ${e.toString()}");
      return ResponseModel<RoomResponseModel>(
        code: 500,
        message: e.toString(),
        data: null,
      );
    }
  }
}
