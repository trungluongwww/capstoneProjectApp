// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeFilterProviderModel {
  String? selectedProvinceId;
  String? provinceName;
  String? selectedDistrictId;
  String? districtName;
  String? selectTedWardId;
  String? wardName;
  String? roomType;
  String? sortField;
  String? sortValue;
  String? keyword;
  int maxPrice;

  HomeFilterProviderModel({
    this.selectedProvinceId,
    this.provinceName,
    this.selectedDistrictId,
    this.districtName,
    this.selectTedWardId,
    this.wardName,
    this.roomType,
    this.sortField,
    this.sortValue,
    this.keyword,
    this.maxPrice = 100000000,
  });

  HomeFilterProviderModel copyWith({
    String? selectedProvinceId,
    String? provinceName,
    String? selectedDistrictId,
    String? districtName,
    String? selectTedWardId,
    String? wardName,
    String? roomType,
    String? sortField,
    String? sortValue,
    String? keyword,
    int? maxPrice,
  }) {
    return HomeFilterProviderModel(
      selectedProvinceId: selectedProvinceId ?? this.selectedProvinceId,
      provinceName: provinceName ?? this.provinceName,
      selectedDistrictId: selectedDistrictId ?? this.selectedDistrictId,
      districtName: districtName ?? this.districtName,
      selectTedWardId: selectTedWardId ?? this.selectTedWardId,
      wardName: wardName ?? this.wardName,
      roomType: roomType ?? this.roomType,
      sortField: sortField ?? this.sortField,
      sortValue: sortValue ?? this.sortValue,
      keyword: keyword ?? this.keyword,
      maxPrice: maxPrice ?? this.maxPrice,
    );
  }
}

class HomeFilterNotifier extends StateNotifier<HomeFilterProviderModel> {
  HomeFilterNotifier() : super(HomeFilterProviderModel());

  void setSelectedProvinceId(String id, String name) {
    if (id != state.selectedProvinceId) {
      state.selectedDistrictId = null;
      state.districtName = null;
      state.selectTedWardId = null;
      state.wardName = null;
      state = state.copyWith(selectedProvinceId: id, provinceName: name);
    }
  }

  void setSelectedDistrictId(String id, String name) {
    if (id != state.selectedDistrictId) {
      state.selectTedWardId = null;
      state.wardName = null;
      state = state.copyWith(selectedDistrictId: id, districtName: name);
    }
  }

  void setSelectTedWardId(String id, String name) {
    if (id != state.selectTedWardId) {
      state = state.copyWith(selectTedWardId: id, wardName: name);
    }
  }

  void setRoomType(String? type) {
    if (type != state.roomType) {
      state = state.copyWith(roomType: type);
    } else {
      state = state.copyWith(roomType: null);
    }
  }

  void setOrderBy(String? field, String? value) {
    if (field != state.sortField || value != state.sortValue) {
      state = state.copyWith(sortField: field, sortValue: value);
    } else {
      state = state.copyWith(sortField: null, sortValue: null);
    }
  }

  void setKeyword(String value) {
    if (value != state.keyword) {
      state = state.copyWith(keyword: value);
    }
  }

  void setMaxPrice(int value) {
    state = state.copyWith(maxPrice: value);
  }

  void reset() {
    state = HomeFilterProviderModel();
  }
}

// provider
final homeFilterProvider =
    StateNotifierProvider<HomeFilterNotifier, HomeFilterProviderModel>(
        (ref) => HomeFilterNotifier());
