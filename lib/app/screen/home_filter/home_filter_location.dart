import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:roomeasy/app/constant/app_color.dart';
import 'package:roomeasy/app/provider/home/home_filter_data.dart';
import 'package:roomeasy/app/provider/home/location.dart';
import 'package:roomeasy/app/widget/list_title/list_title_select_option.dart';
import 'package:roomeasy/model/location/district.dart';
import 'package:roomeasy/model/location/province.dart';
import 'package:roomeasy/model/location/ward.dart';
import 'package:roomeasy/model/response/response.dart';

class HomeFilterLocation extends ConsumerWidget {
  const HomeFilterLocation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AsyncValue<ResponseModel<ProvinceResponseModel>> provinces =
        ref.watch(provinceProvider);

    AsyncValue<ResponseModel<DistrictResponseModel>?> districts =
        ref.watch(districtProvider);
    AsyncValue<ResponseModel<WardResponseModel>?> wards =
        ref.watch(wardProvider);

    HomeFilterProviderModel homeFilters = ref.watch(homeFilterProvider);

    void showModalSelectProvince() {
      showModalBottomSheet(
          context: context,
          builder: (BuildContext context) {
            return Container(
              constraints: const BoxConstraints(maxHeight: 400),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          color: AppColor.appTextBlurColor,
                          icon: const Icon(Icons.close)),
                      TextButton(
                        onPressed: () {},
                        child: const Text("Chọn"),
                      ),
                    ],
                  ),
                  Expanded(
                      child: provinces.when(
                          data: (res) {
                            if (res.code.toString().startsWith('2')) {
                              return ListView.builder(
                                  itemCount: res.data!.total,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return InkWell(
                                      onTap: () {
                                        ref
                                            .read(homeFilterProvider.notifier)
                                            .setSelectedProvinceId(
                                                res.data!.provinces![index].id);
                                        Navigator.pop(context);
                                      },
                                      child: ListTile(
                                        title: Text(
                                            res.data!.provinces![index].name),
                                      ),
                                    );
                                  });
                            } else {
                              return const SizedBox();
                            }
                          },
                          error: (error, stackTrace) => const Center(
                                child: CircularProgressIndicator(),
                              ),
                          loading: () => const Center(
                                child: CircularProgressIndicator(),
                              )))
                ],
              ),
            );
          });
    }

    void showModalSelectDistrict() {
      if (homeFilters.selectedProvinceId == null) {
        return;
      }
      showModalBottomSheet(
          context: context,
          builder: (BuildContext context) {
            return Container(
              constraints: const BoxConstraints(maxHeight: 400),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          color: AppColor.appTextBlurColor,
                          icon: const Icon(Icons.close)),
                      TextButton(
                        onPressed: () {},
                        child: const Text("Chọn"),
                      ),
                    ],
                  ),
                  Expanded(
                      child: districts.when(
                          data: (res) {
                            if (res != null &&
                                res.code.toString().startsWith('2')) {
                              return ListView.builder(
                                  itemCount: res.data!.total,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return InkWell(
                                      onTap: () {
                                        ref
                                            .read(homeFilterProvider.notifier)
                                            .setSelectedDistrictId(
                                                res.data!.districts![index].id);
                                        Navigator.pop(context);
                                      },
                                      child: ListTile(
                                        title: Text(
                                            res.data!.districts![index].name),
                                      ),
                                    );
                                  });
                            } else {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                          },
                          error: (error, stackTrace) => const Center(
                                child: CircularProgressIndicator(),
                              ),
                          loading: () => const Center(
                                child: CircularProgressIndicator(),
                              )))
                ],
              ),
            );
          });
    }

    void showModalSelectWard() {
      if (homeFilters.selectedDistrictId == null) {
        return;
      }
      showModalBottomSheet(
          context: context,
          builder: (BuildContext context) {
            return Container(
              constraints: const BoxConstraints(maxHeight: 400),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          color: AppColor.appTextBlurColor,
                          icon: const Icon(Icons.close)),
                      TextButton(
                        onPressed: () {},
                        child: const Text("Chọn"),
                      ),
                    ],
                  ),
                  Expanded(
                      child: wards.when(
                          data: (res) {
                            if (res != null &&
                                res.code.toString().startsWith('2')) {
                              return ListView.builder(
                                  itemCount: res.data!.total,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return InkWell(
                                      onTap: () {
                                        ref
                                            .read(homeFilterProvider.notifier)
                                            .setSelectedDistrictId(
                                                res.data!.wards![index].id);
                                        Navigator.pop(context);
                                      },
                                      child: ListTile(
                                        title:
                                            Text(res.data!.wards![index].name),
                                      ),
                                    );
                                  });
                            } else {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                          },
                          error: (error, stackTrace) => const Center(
                                child: CircularProgressIndicator(),
                              ),
                          loading: () => const Center(
                                child: CircularProgressIndicator(),
                              )))
                ],
              ),
            );
          });
    }

    return Container(
      width: double.infinity,
      height: 500,
      color: AppColor.appDarkWhiteColor,
      constraints: const BoxConstraints(
        minHeight: 0,
        maxHeight: double.infinity,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10, top: 5, bottom: 5),
            child: Text("Khu vực",
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(color: AppColor.appTextBlurColor)),
          ),
          ListTitleSelectOption(
            title: "Tỉnh/ Thành phố",
            onTab: showModalSelectProvince,
            trailing: const Icon(Icons.keyboard_arrow_right),
          ),
          ListTitleSelectOption(
            title: "Quận/ Huyện",
            onTab: showModalSelectDistrict,
            trailing: const Icon(Icons.keyboard_arrow_right),
          ),
          ListTitleSelectOption(
            title: "Phường/ Xã",
            onTab: showModalSelectWard,
            trailing: const Icon(Icons.keyboard_arrow_right),
          )
        ],
      ),
    );
  }
}
