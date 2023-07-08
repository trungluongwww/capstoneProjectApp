import 'package:flutter/material.dart';
import 'package:roomeasy/api/constant/constant.dart';
import 'package:roomeasy/api/services/base/base.dart';
import 'package:roomeasy/model/location/district.dart';
import 'package:roomeasy/model/location/province.dart';
import 'package:roomeasy/model/location/ward.dart';
import 'package:roomeasy/model/response/response.dart';

class LocationService extends BaseService {
  LocationService() : super();

  Future<ResponseModel<ProvinceResponseModel>> getProvinces() async {
    try {
      final url = Apiconstants.getUri(
          "${Apiconstants.apiVersion}${Apiconstants.locationEndpoint}/provinces",
          null);

      var response = await get(uri: url);

      if (response.data != null) {
        var result = ResponseModel<ProvinceResponseModel>(
            code: response.code,
            message: response.message,
            data: ProvinceResponseModel.fromMap(response.data!));

        return result;
      }

      return ResponseModel<ProvinceResponseModel>(
        code: response.code,
        message: response.message,
        data: null,
      );
    } catch (e) {
      debugPrint("Error in api.service.location.getProvinces: ${e.toString()}");
      return ResponseModel<ProvinceResponseModel>(
        code: 500,
        message: e.toString(),
        data: null,
      );
    }
  }

  Future<ResponseModel<DistrictResponseModel>> getDistricts(
      {required String id}) async {
    try {
      final url = Apiconstants.getUri(
          "${Apiconstants.apiVersion}${Apiconstants.locationEndpoint}/districts",
          {'provinceId': id});

      var response = await get(uri: url);

      if (response.data != null) {
        var result = ResponseModel<DistrictResponseModel>(
            code: response.code,
            message: response.message,
            data: DistrictResponseModel.fromMap(response.data!));

        return result;
      }

      return ResponseModel<DistrictResponseModel>(
        code: response.code,
        message: response.message,
        data: null,
      );
    } catch (e) {
      debugPrint("Error in api.service.location.getDistricts: ${e.toString()}");
      return ResponseModel<DistrictResponseModel>(
        code: 500,
        message: e.toString(),
        data: null,
      );
    }
  }

  Future<ResponseModel<WardResponseModel>> getWards(
      {required String id}) async {
    try {
      final url = Apiconstants.getUri(
          "${Apiconstants.apiVersion}${Apiconstants.locationEndpoint}/wards",
          {'districtId': id});

      var response = await get(uri: url);

      if (response.data != null) {
        var result = ResponseModel<WardResponseModel>(
            code: response.code,
            message: response.message,
            data: WardResponseModel.fromMap(response.data!));

        return result;
      }

      return ResponseModel<WardResponseModel>(
        code: response.code,
        message: response.message,
        data: null,
      );
    } catch (e) {
      debugPrint("Error in api.service.location.getWards: ${e.toString()}");
      return ResponseModel<WardResponseModel>(
        code: 500,
        message: e.toString(),
        data: null,
      );
    }
  }
}
