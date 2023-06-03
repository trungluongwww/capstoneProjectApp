import 'package:flutter/material.dart';
import 'package:roomeasy/api/constant/constant.dart';
import 'package:roomeasy/api/services/base/baseModel.dart';
import 'package:roomeasy/form/message/message_create.dart';
import 'package:roomeasy/model/conversation/conversation.dart';
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
      debugPrint("Error in api.service.conversation.getAll: ${e.toString()}");
      return ResponseModel<ConversationResponseModel>(
        code: 500,
        message: e.toString(),
        data: null,
      );
    }
  }

  Future<ResponseModel<ConversationModel>> getDetail(String id) async {
    try {
      final uri = Uri.http(
        Apiconstants.getBaseURL(),
        "${Apiconstants.apiVersion}${Apiconstants.conversationEndpoint}/$id",
      );

      var response = await get(uri: uri);

      if (!response.code.toString().startsWith('2')) {
        debugPrint(
            "[APIService] ${uri.toString()} code:${response.code} message:${response.message}");
      }

      return ResponseModel<ConversationModel>(
        code: response.code,
        message: response.message,
        data: response.data != null
            ? ConversationModel.fromMap(response.data!['conversation'])
            : null,
      );
    } catch (e) {
      debugPrint(
          "Error in api.service.conversation.getDetail: ${e.toString()}");
      return ResponseModel<ConversationModel>(
        code: 500,
        message: e.toString(),
        data: null,
      );
    }
  }

  Future<ResponseModel<dynamic>> sendMessage(
      String conversationId, MessageCreateFormModel formdata) async {
    try {
      final uri = Uri.http(
        Apiconstants.getBaseURL(),
        "${Apiconstants.apiVersion}${Apiconstants.conversationEndpoint}/$conversationId/message",
      );

      var response = await post(uri: uri, body: formdata.toMap());

      if (!response.code.toString().startsWith('2')) {
        debugPrint(
            "[APIService] ${uri.toString()} code:${response.code} message:${response.message}");
      }

      return ResponseModel<dynamic>(
        code: response.code,
        message: response.message,
        data: null,
      );
    } catch (e) {
      debugPrint(
          "Error in api.service.conversation.sendMessage: ${e.toString()}");
      return ResponseModel<dynamic>(
        code: 500,
        message: e.toString(),
        data: null,
      );
    }
  }
}
