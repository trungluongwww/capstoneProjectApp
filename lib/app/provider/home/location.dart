import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:roomeasy/api/services/location/location.dart';
import 'package:roomeasy/app/provider/home/home_filter_data.dart';
import 'package:roomeasy/model/location/district.dart';
import 'package:roomeasy/model/location/province.dart';
import 'package:roomeasy/model/location/ward.dart';
import 'package:roomeasy/model/response/response.dart';

final provinceProvider =
    FutureProvider<ResponseModel<ProvinceResponseModel>>((ref) async {
  return await LocationService().getProvinces();
});

final districtProvider =
    FutureProvider<ResponseModel<DistrictResponseModel>?>((ref) async {
  final provinceId = ref.watch(homeFilterProvider).selectedProvinceId;
  return provinceId != null
      ? await LocationService().getDistricts(id: provinceId)
      : null;
});

final wardProvider =
    FutureProvider<ResponseModel<WardResponseModel>?>((ref) async {
  final districtId = ref.watch(homeFilterProvider).selectedDistrictId;
  return districtId != null
      ? await LocationService().getWards(id: districtId)
      : null;
});

// util
