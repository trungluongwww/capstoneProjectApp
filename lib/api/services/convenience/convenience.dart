import 'package:flutter/material.dart';
import 'package:roomeasy/api/constant/constant.dart';
import 'package:roomeasy/api/services/base/base.dart';
import 'package:roomeasy/model/convenience/covnenience_response.dart';
import 'package:roomeasy/model/response/response.dart';

class ConvenienceService extends BaseService {
  ConvenienceService() : super();

  Future<ResponseModel<ConvenienceResponseModel>> getAll() async {
    try {
      final uri = Uri.http(Apiconstants.getBaseURL(),
          "${Apiconstants.apiVersion}${Apiconstants.convenienceEndPoint}");

      var response = await get(uri: uri);

      if (!response.code.toString().startsWith('2')) {
        debugPrint(
            "[APIService] ${uri.toString()} code:${response.code} message:${response.message}");
      }

      return ResponseModel<ConvenienceResponseModel>(
        code: response.code,
        message: response.message,
        data: response.data != null
            ? ConvenienceResponseModel.fromMap(response.data!)
            : null,
      );
    } catch (e) {
      debugPrint("Error in api.service.convenience.getAll: ${e.toString()}");
      return ResponseModel<ConvenienceResponseModel>(
        code: 500,
        message: e.toString(),
        data: null,
      );
    }
  }
}
