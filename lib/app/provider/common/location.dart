import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:roomeasy/api/services/location/location.dart';
import 'package:roomeasy/model/location/district.dart';
import 'package:roomeasy/model/location/province.dart';
import 'package:roomeasy/model/location/ward.dart';
import 'package:roomeasy/model/response/response.dart';

final commonProvinceProvider =
    FutureProvider.autoDispose<ResponseModel<ProvinceResponseModel>>(
        (ref) async {
  return await LocationService().getProvinces();
});

final commonDistrictProvider = FutureProvider.autoDispose
    .family<ResponseModel<DistrictResponseModel>?, String>(
        (ref, provinceId) async {
  if (provinceId.isEmpty) return null;
  return await LocationService().getDistricts(id: provinceId);
});

final commonWardProvider = FutureProvider.autoDispose
    .family<ResponseModel<WardResponseModel>?, String>((ref, districtId) async {
  return await LocationService().getWards(id: districtId);
});
