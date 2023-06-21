import 'package:flutter/foundation.dart';

class Apiconstants {
  // domain
  // static String devBaseUrl = "10.0.2.2:5000";
  static String devBaseUrl = "192.168.1.11:5000";
  static String productBaseUrl = "admin.capstone-trungluong.com";

  // apiversion
  static String apiVersion = "/api";

  // services
  static String filterEndpoint = "/filters";
  static String roomEndpoint = "/rooms";
  static String userEndpoint = "/users";
  static String conversationEndpoint = "/conversations";
  static String locationEndpoint = "/locations";
  static String uploadEndpoint = "/uploads";
  static String convenienceEndPoint = "/conveniences";

  // key
  static String authToken = 'auth_token';

  static String getSocketURI() {
    if (kReleaseMode) {
      return 'https://$productBaseUrl';
    }
    return 'http://$devBaseUrl';
  }

  static Uri getUri(String endpoint, Map<String, dynamic>? params) {
    if (kReleaseMode) {
      return Uri.https(productBaseUrl, endpoint, params);
    }
    return Uri.http(devBaseUrl, endpoint, params);
  }
}
