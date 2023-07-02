import 'package:flutter/material.dart';

import 'package:roomeasy/api/constant/constant.dart';
import 'package:roomeasy/api/services/base/base.dart';
import 'package:roomeasy/form/login/login.dart';
import 'package:roomeasy/form/register/register.dart';
import 'package:roomeasy/form/user/user_change_avatar.dart';
import 'package:roomeasy/form/user/user_change_password.dart';
import 'package:roomeasy/form/user/user_update.dart';
import 'package:roomeasy/model/auth/profile.dart';
import 'package:roomeasy/model/response/response.dart';
import 'package:roomeasy/model/room/room_response.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthServices extends BaseService {
  static AuthProfileModel? user;

  AuthProfileModel? getCurrentUserState() {
    return user;
  }

  void removeCurrentUserState() async {
    user = null;
    var instance = await SharedPreferences.getInstance();
    instance.remove(Apiconstants.authToken);
  }

  Future<ResponseModel<String>> login(
      {required LoginFormModel formData}) async {
    try {
      final uri = Apiconstants.getUri(
          '${Apiconstants.apiVersion}${Apiconstants.userEndpoint}/login', null);
      final res = await post(uri: uri, body: formData.toMap());
      if (!res.code.toString().startsWith('2')) {
        debugPrint(
            "[APIService] ${uri.toString()} code:${res.code} message:${res.message}");
      }

      String token = res.data != null ? res.data!['token'] : '';

      var instance = await SharedPreferences.getInstance();
      instance.setString(Apiconstants.authToken, token);

      return ResponseModel<String>(
          code: res.code, message: res.message, data: token);
    } catch (e) {
      return ResponseModel<String>(
        code: 500,
        message: e.toString(),
        data: null,
      );
    }
  }

  Future<ResponseModel<String>> register(
      {required RegisterFormModel formData}) async {
    try {
      final uri = Apiconstants.getUri(
          '${Apiconstants.apiVersion}${Apiconstants.userEndpoint}/register',
          null);

      final res = await post(uri: uri, body: formData.toMap());
      if (!res.code.toString().startsWith('2')) {
        debugPrint(
            "[APIService] ${uri.toString()} code:${res.code} message:${res.message}");
      }

      String token = res.data != null && res.data!['token'] != null
          ? res.data!['token']
          : '';

      var instance = await SharedPreferences.getInstance();
      instance.setString(Apiconstants.authToken, token);

      return ResponseModel<String>(
          code: res.code, message: res.message, data: token);
    } catch (e) {
      return ResponseModel<String>(
        code: 500,
        message: e.toString(),
        data: null,
      );
    }
  }

  Future<ResponseModel<AuthProfileModel>> getMe() async {
    try {
      final uri = Apiconstants.getUri(
          "${Apiconstants.apiVersion}${Apiconstants.userEndpoint}/me", null);

      var response = await get(uri: uri);
      if (!response.code.toString().startsWith('2')) {
        debugPrint(
            "[APIService] ${uri.toString()} code:${response.code} message:${response.message}");
      }

      if (response.data != null) {
        user = AuthProfileModel.fromMap(response.data!);
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

  Future<ResponseModel<AuthProfileModel>> getUserProfile(
      {required String userId}) async {
    try {
      final uri = Apiconstants.getUri(
          "${Apiconstants.apiVersion}${Apiconstants.userEndpoint}/profile",
          {"userId": userId});

      var response = await get(uri: uri);
      if (!response.code.toString().startsWith('2')) {
        debugPrint(
            "[APIService] ${uri.toString()} code:${response.code} message:${response.message}");
      }

      return ResponseModel<AuthProfileModel>(
        code: response.code,
        message: response.message,
        data: response.data != null
            ? AuthProfileModel.fromMap(response.data!)
            : null,
      );
    } catch (e) {
      debugPrint("Error in api.service.auth.getUserProfile: ${e.toString()}");
      return ResponseModel<AuthProfileModel>(
        code: 500,
        message: e.toString(),
        data: null,
      );
    }
  }

  Future<ResponseModel> updateProfile(UserUpdateFormModel formdata) async {
    try {
      final url = Apiconstants.getUri(
          "${Apiconstants.apiVersion}${Apiconstants.userEndpoint}", null);

      var response = await put(uri: url, body: formdata.toMap());
      if (!response.code.toString().startsWith('2')) {
        debugPrint(
            "[APIService] ${url.toString()} code:${response.code} message:${response.message}");
      }

      return ResponseModel(
          code: response.code, message: response.message, data: null);
    } catch (e) {
      debugPrint("Error in api.service.auth.updateProfile: ${e.toString()}");
      return ResponseModel<AuthProfileModel>(
        code: 500,
        message: e.toString(),
        data: null,
      );
    }
  }

  Future<ResponseModel> updateAvatar(UserChangeAvatarFormModel formdata) async {
    try {
      final url = Apiconstants.getUri(
          "${Apiconstants.apiVersion}${Apiconstants.userEndpoint}/avatar",
          null);

      var response = await patch(uri: url, body: formdata.toMap());
      if (!response.code.toString().startsWith('2')) {
        debugPrint(
            "[APIService] ${url.toString()} code:${response.code} message:${response.message}");
      }

      return ResponseModel(
          code: response.code, message: response.message, data: null);
    } catch (e) {
      debugPrint("Error in api.service.auth.updateAvatar: ${e.toString()}");
      return ResponseModel<AuthProfileModel>(
        code: 500,
        message: e.toString(),
        data: null,
      );
    }
  }

  Future<ResponseModel> changePassword(
      UserChangePassWordFormModel formdata) async {
    try {
      final url = Apiconstants.getUri(
          "${Apiconstants.apiVersion}${Apiconstants.userEndpoint}/password",
          null);

      var response = await patch(uri: url, body: formdata.toMap());
      if (!response.code.toString().startsWith('2')) {
        debugPrint(
            "[APIService] ${url.toString()} code:${response.code} message:${response.message}");
      }

      return ResponseModel(
          code: response.code, message: response.message, data: null);
    } catch (e) {
      debugPrint("Error in api.service.auth.changePassword: ${e.toString()}");
      return ResponseModel<AuthProfileModel>(
        code: 500,
        message: e.toString(),
        data: null,
      );
    }
  }

  // manage room
  Future<ResponseModel<RoomResponseModel>> getMyRooms(String pageToken) async {
    Map<String, dynamic> params = {
      'pageToken': pageToken,
    };

    try {
      final url = Apiconstants.getUri(
          "${Apiconstants.apiVersion}${Apiconstants.userEndpoint}/rooms",
          params);

      var response = await get(uri: url);
      if (!response.code.toString().startsWith('2')) {
        debugPrint(
            "[APIService] ${url.toString()} code:${response.code} message:${response.message}");
      }
      return ResponseModel<RoomResponseModel>(
        code: response.code,
        message: response.message,
        data: response.data != null
            ? RoomResponseModel.fromMap(response.data!)
            : null,
      );
    } catch (e) {
      debugPrint("Error in api.service.auth.getMyRooms: ${e.toString()}");
      return ResponseModel<RoomResponseModel>(
        code: 500,
        message: e.toString(),
        data: null,
      );
    }
  }

  Future<ResponseModel> addToFavouriteRoom(String roomId) async {
    try {
      final url = Apiconstants.getUri(
          "${Apiconstants.apiVersion}${Apiconstants.userEndpoint}/favourite-room",
          null);

      var response = await post(uri: url, body: {'roomId': roomId});
      if (!response.code.toString().startsWith('2')) {
        debugPrint(
            "[APIService] ${url.toString()} code:${response.code} message:${response.message}");
      }

      return ResponseModel(
          code: response.code, message: response.message, data: null);
    } catch (e) {
      debugPrint(
          "Error in api.service.auth.addToFavouriteRoom: ${e.toString()}");
      return ResponseModel<AuthProfileModel>(
        code: 500,
        message: e.toString(),
        data: null,
      );
    }
  }

  Future<ResponseModel> removeFavouriteRoom(String roomId) async {
    try {
      final url = Apiconstants.getUri(
          "${Apiconstants.apiVersion}${Apiconstants.userEndpoint}/favourite-room",
          null);

      var response = await delete(uri: url, body: {'roomId': roomId});
      if (!response.code.toString().startsWith('2')) {
        debugPrint(
            "[APIService] ${url.toString()} code:${response.code} message:${response.message}");
      }

      return ResponseModel(
          code: response.code, message: response.message, data: null);
    } catch (e) {
      debugPrint(
          "Error in api.service.auth.removeFavouriteRoom: ${e.toString()}");
      return ResponseModel<AuthProfileModel>(
        code: 500,
        message: e.toString(),
        data: null,
      );
    }
  }

  Future<ResponseModel<RoomResponseModel>> getFavouriteRooms(
      String pageToken) async {
    Map<String, dynamic> params = {
      'pageToken': pageToken,
    };

    try {
      final url = Apiconstants.getUri(
          "${Apiconstants.apiVersion}${Apiconstants.userEndpoint}/favourite-room",
          params);

      var response = await get(uri: url);
      if (!response.code.toString().startsWith('2')) {
        debugPrint(
            "[APIService] ${url.toString()} code:${response.code} message:${response.message}");
      }
      return ResponseModel<RoomResponseModel>(
        code: response.code,
        message: response.message,
        data: response.data != null
            ? RoomResponseModel.fromMap(response.data!)
            : null,
      );
    } catch (e) {
      debugPrint(
          "Error in api.service.auth.getFavouriteRooms: ${e.toString()}");
      return ResponseModel<RoomResponseModel>(
        code: 500,
        message: e.toString(),
        data: null,
      );
    }
  }
}
