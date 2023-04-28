import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import 'package:roomeasy/api/constant/constant.dart';

class AuthAPI {
  Future<String?> login(String username, String password) async {
    final uri = Uri.http(Apiconstants.baseUrl,
        '${Apiconstants.api}${Apiconstants.userEndpoint}/login');
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
}
