import 'package:flutter/material.dart';
import 'package:roomeasy/api/constant/constant.dart';
import 'package:roomeasy/api/services/base/baseModel.dart';
import 'package:roomeasy/model/filter/room_filter.dart';
import 'package:roomeasy/model/response/response.dart';

class RoomServices extends BaseService {
  RoomServices() : super();

  Future<ResponseModel<RoomFilterModel>> getFilters() async {
    try {
      final url = Uri.http(Apiconstants.baseUrl,
          "${Apiconstants.apiVersion}${Apiconstants.filterEndpoint}/");

      var response = await get(uri: url);

      if (response.data != null) {
        var result = ResponseModel<RoomFilterModel>(
            code: response.code,
            message: response.message,
            data: RoomFilterModel.fromMap(response.data!['room']));

        return result;
      }

      return ResponseModel<RoomFilterModel>(
        code: response.code,
        message: response.message,
        data: null,
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
}
