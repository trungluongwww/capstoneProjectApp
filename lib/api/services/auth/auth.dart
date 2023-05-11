import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:roomeasy/api/constant/constant.dart';
import 'package:roomeasy/api/services/base/baseModel.dart';
import 'package:roomeasy/model/auth/profile.dart';
import 'package:roomeasy/model/response/response.dart';

class AuthServices extends BaseService {
  Future<String?> login(String username, String password) async {
    final uri = Uri.http(Apiconstants.baseUrl,
        '${Apiconstants.apiVersion}${Apiconstants.userEndpoint}/login');
    var body = json.encode({'username': username, 'password': password});
    try {
      final res = await http.post(uri,
          headers: {'Content-Type': 'application/json'}, body: body);
      if (res.statusCode.toString().startsWith('2')) {
        return (jsonDecode(utf8.decode(res.bodyBytes)) as Map)['data']['token'];
      }

      return null;
    } catch (e) {
      return null;
    }
  }

  Future<ResponseModel<AuthProfileModel>> getMe() async {
    try {
      final url = Uri.http(Apiconstants.baseUrl,
          "${Apiconstants.apiVersion}${Apiconstants.userEndpoint}/me");

      var response = await get(uri: url);
      if (!response.code.toString().startsWith('2')) {
        debugPrint(
            "[APIService] ${url.toString()} code:${response.code} message:${response.message}");
      }
      return ResponseModel<AuthProfileModel>(
        code: response.code,
        message: response.message,
        data: response.data != null
            ? AuthProfileModel.fromMap(response.data!)
            : null,
      );
    } catch (e) {
      debugPrint("Error in api.service.auth.getMe: ${e.toString()}");
      return ResponseModel<AuthProfileModel>(
        code: 500,
        message: e.toString(),
        data: null,
      );
    }
  }
}
