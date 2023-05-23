import 'package:flutter/material.dart';
import 'package:roomeasy/api/constant/constant.dart';
import 'package:roomeasy/api/services/base/baseModel.dart';
import 'package:roomeasy/form/room/room_create.dart';
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
}
