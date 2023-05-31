import 'package:flutter/material.dart';
import 'package:roomeasy/api/constant/constant.dart';
import 'package:roomeasy/api/services/base/baseModel.dart';
import 'package:roomeasy/model/conversation/conversation_response.dart';
import 'package:roomeasy/model/response/response.dart';

class ConversationService extends BaseService {
  ConversationService() : super();

  Future<ResponseModel<ConversationResponseModel>> getAll(
      String pageToken) async {
    Map<String, dynamic> params = {
      'pageToken': pageToken,
    };
    try {
      final uri = Uri.http(
          Apiconstants.getBaseURL(),
          "${Apiconstants.apiVersion}${Apiconstants.conversationEndpoint}",
          params);

      var response = await get(uri: uri);

      if (!response.code.toString().startsWith('2')) {
        debugPrint(
            "[APIService] ${uri.toString()} code:${response.code} message:${response.message}");
      }

      return ResponseModel<ConversationResponseModel>(
        code: response.code,
        message: response.message,
        data: response.data != null
            ? ConversationResponseModel.fromMap(response.data!)
            : null,
      );
    } catch (e) {
      debugPrint("Error in api.service.convenience.getAll: ${e.toString()}");
      return ResponseModel<ConversationResponseModel>(
        code: 500,
        message: e.toString(),
        data: null,
      );
    }
  }
}
