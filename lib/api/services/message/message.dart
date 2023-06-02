import 'package:flutter/material.dart';
import 'package:roomeasy/api/constant/constant.dart';
import 'package:roomeasy/api/services/base/baseModel.dart';
import 'package:roomeasy/model/message/message_response.dart';
import 'package:roomeasy/model/response/response.dart';

class MessageService extends BaseService {
  MessageService();

  Future<ResponseModel<MessageResponseModel>> getAll(
      String id, String pageToken) async {
    Map<String, dynamic> params = {
      'pageToken': pageToken,
    };
    try {
      final uri = Uri.http(
          Apiconstants.getBaseURL(),
          "${Apiconstants.apiVersion}${Apiconstants.conversationEndpoint}/$id/messages",
          params);

      var response = await get(uri: uri);

      if (!response.code.toString().startsWith('2')) {
        debugPrint(
            "[APIService] ${uri.toString()} code:${response.code} message:${response.message}");
      }

      return ResponseModel<MessageResponseModel>(
        code: response.code,
        message: response.message,
        data: response.data != null
            ? MessageResponseModel.fromMap(response.data!)
            : null,
      );
    } catch (e) {
      debugPrint("Error in api.service.message.getAll: ${e.toString()}");
      return ResponseModel<MessageResponseModel>(
        code: 500,
        message: e.toString(),
        data: null,
      );
    }
  }
}
