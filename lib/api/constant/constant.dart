import 'package:flutter/foundation.dart';

class Apiconstants {
  // domain
  // static String devBaseUrl = "10.0.2.2:5000";
  static String devBaseUrl = "192.168.1.10:5000";
  static String productBaseUrl = "34.124.228.220";

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

  static String getBaseURL() {
    if (kReleaseMode) {
      return productBaseUrl;
    }
    return devBaseUrl;
  }
}
