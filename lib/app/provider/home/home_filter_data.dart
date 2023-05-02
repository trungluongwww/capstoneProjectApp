// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeFilterProviderModel {
  String? selectedProvinceId;
  String? selectedDistrictId;
  String? selectTedWardId;

  HomeFilterProviderModel({
    this.selectedProvinceId,
    this.selectedDistrictId,
    this.selectTedWardId,
  });

  HomeFilterProviderModel copyWith({
    String? selectedProvinceId,
    String? selectedDistrictId,
    String? selectTedWardId,
  }) {
    return HomeFilterProviderModel(
      selectedProvinceId: selectedProvinceId ?? this.selectedProvinceId,
      selectedDistrictId: selectedDistrictId ?? this.selectedDistrictId,
      selectTedWardId: selectTedWardId ?? this.selectTedWardId,
    );
  }
}

class HomeFilterNotifier extends StateNotifier<HomeFilterProviderModel> {
  HomeFilterNotifier() : super(HomeFilterProviderModel());

  void setSelectedProvinceId(String id) {
    if (id != state.selectedProvinceId) {
      state = state.copyWith(selectedProvinceId: id);
    }
  }

  void setSelectedDistrictId(String id) {
    if (id != state.selectedDistrictId) {
      state = state.copyWith(selectedDistrictId: id);
    }
  }

  void setSelectTedWardId(String id) {
    if (id != state.selectTedWardId) {
      state = state.copyWith(selectTedWardId: id);
    }
  }
}

// provider
final homeFilterProvider =
    StateNotifierProvider<HomeFilterNotifier, HomeFilterProviderModel>(
        (ref) => HomeFilterNotifier());
