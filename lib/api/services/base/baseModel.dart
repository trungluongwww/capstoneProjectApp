// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:roomeasy/api/constant/constant.dart';
import 'package:roomeasy/model/response/response.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class BaseService {
  Future<Map<String, String>> _getHeader() async {
    var token = await _getToken();
    return {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${token ?? ""}',
    };
  }

  Future<String?> _getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(Apiconstants.authToken);
  }

  Future<void> setToken({required String token}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(Apiconstants.authToken, token);
  }

  // http get
  Future<ResponseModel<Map<String, dynamic>>> get({required Uri uri}) async {
    try {
      var res = await http.get(uri, headers: await _getHeader());
      return ResponseModel.fromJson(res.body, res.statusCode);
    } catch (e) {
      return ResponseModel.fromMap({
        'message': e.toString(),
      }, 500);
    }
  }

  // http post
  Future<ResponseModel<Map<String, dynamic>>> post(
      {required Uri uri, required Map<String, dynamic> body}) async {
    try {
      var res = await http.post(uri,
          headers: await _getHeader(), body: json.encode(body));

      return ResponseModel.fromJson(res.body, res.statusCode);
    } catch (e) {
      return ResponseModel.fromMap({
        'message': e.toString(),
      }, 500);
    }
  }

  // http put
  Future<ResponseModel<Map<String, dynamic>>> put(
      {required Uri uri, required Map<String, dynamic> body}) async {
    try {
      var res = await http.put(uri,
          headers: await _getHeader(), body: json.encode(body));

      return ResponseModel.fromJson(res.body, res.statusCode);
    } catch (e) {
      return ResponseModel.fromMap({
        'message': e.toString(),
      }, 500);
    }
  }

  // http patch
  Future<ResponseModel<Map<String, dynamic>>> patch(
      {required Uri uri, required Map<String, dynamic> body}) async {
    try {
      var res = await http.patch(uri,
          headers: await _getHeader(), body: json.encode(body));

      return ResponseModel.fromJson(res.body, res.statusCode);
    } catch (e) {
      return ResponseModel.fromMap({
        'message': e.toString(),
      }, 500);
    }
  }

  // http patch
  Future<ResponseModel<Map<String, dynamic>>> delete({required Uri uri}) async {
    try {
      var res = await http.delete(uri, headers: await _getHeader());

      return ResponseModel.fromJson(res.body, res.statusCode);
    } catch (e) {
      return ResponseModel.fromMap({
        'message': e.toString(),
      }, 500);
    }
  }
}
