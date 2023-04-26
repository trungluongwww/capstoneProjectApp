import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import 'package:roomeasy/api/constant/constant.dart';

class AuthAPI {
  Future<String?> login(String username, String password) async {
    final uri = Uri.http(Apiconstants.host,
        '${Apiconstants.api}${Apiconstants.userEndpoint}/login');
    print(uri);
    try {
      final res = await http.Client().post(uri, body: {
        "username": username,
        "password": password,
      });

      print("res");
      print(res);

      if (res.statusCode.toString().startsWith('2')) {
        return (jsonDecode(utf8.decode(res.bodyBytes)) as Map)['data']['token'];
      }

      return null;
    } catch (e) {
      print(e);
      return null;
    }
  }
}
