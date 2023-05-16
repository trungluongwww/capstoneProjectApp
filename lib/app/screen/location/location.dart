// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:roomeasy/app/constant/app_color.dart';
import 'package:roomeasy/app/provider/common/location.dart';
import 'package:roomeasy/app/provider/home/home_filter_data.dart';
import 'package:roomeasy/app/widget/common/list_title_select_option.dart';
import 'package:roomeasy/form/location/location.dart';
import 'package:roomeasy/model/location/district.dart';
import 'package:roomeasy/model/location/province.dart';
import 'package:roomeasy/model/location/ward.dart';
import 'package:roomeasy/model/response/response.dart';

class SelectLocationScreen extends ConsumerStatefulWidget {
  static const routerName = '/location';
  final LocationFormModel input;
  const SelectLocationScreen({
    Key? key,
    required this.input,
  }) : super(key: key);

  @override
  SelectLocationScreenState createState() => SelectLocationScreenState();
}

class SelectLocationScreenState extends ConsumerState<SelectLocationScreen> {
  late LocationFormModel formResult;

  @override
  void initState() {
    formResult = widget.input.copyWith();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AsyncValue<ResponseModel<ProvinceResponseModel>> provinces =
        ref.watch(commonProvinceProvider);
    AsyncValue<ResponseModel<DistrictResponseModel>?> districts =
        ref.watch(commonDistrictProvider(formResult.provinceId ?? ""));
    AsyncValue<ResponseModel<WardResponseModel>?> wards =
        ref.watch(commonWardProvider(formResult.districtId ?? ""));

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
                                        setState(() {
                                          formResult.wardId = null;
                                          formResult.wardName = null;
                                          formResult.districtId = null;
                                          formResult.districtName = null;
                                          formResult = formResult.copyWith(
                                            provinceId:
                                                res.data!.provinces![index].id,
                                            provinceName: res
                                                .data!.provinces![index].name,
                                          );
                                        });
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
                                child: CircularProgressIndicator(
                                  color: Colors.red,
                                ),
                              ),
                          loading: () => const Center(
                                child: CircularProgressIndicator(
                                  color: Colors.red,
                                ),
                              )))
                ],
              ),
            );
          });
    }

    void showModalSelectDistrict() {
      if (formResult.provinceId == null) {
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
                                        setState(() {
                                          formResult.wardId = null;
                                          formResult.wardName = null;
                                          formResult = formResult.copyWith(
                                            districtId:
                                                res.data!.districts![index].id,
                                            districtName: res
                                                .data!.districts![index].name,
                                          );
                                        });
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
      if (formResult.districtId == null) {
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
                                        setState(() {
                                          formResult = formResult.copyWith(
                                              wardId:
                                                  res.data!.wards![index].id,
                                              wardName:
                                                  res.data!.wards![index].name);
                                        });

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

    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pop<LocationFormModel>(widget.input);
        return true;
      },
      child: SafeArea(
        top: false,
        child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.white,
            leading: const BackButton(color: AppColor.appPrimaryColor),
            title: Text(
              'Chọn địa chỉ',
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(fontSize: 16, color: Colors.black87),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop<LocationFormModel>(formResult);
                  },
                  child: Text(
                    'Xong',
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(fontSize: 16, color: Colors.black87),
                  ))
            ],
          ),
          body: Container(
            width: double.infinity,
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
                  title: provinces.value != null &&
                          formResult.provinceId != null
                      ? provinces.value!.data!.provinces!
                          .firstWhere(
                              (element) => element.id == formResult.provinceId)
                          .name
                      : "Tỉnh/ Thành phố",
                  onTab: showModalSelectProvince,
                  trailing: const Icon(Icons.keyboard_arrow_right),
                ),
                ListTitleSelectOption(
                  title: districts.value != null &&
                          formResult.districtId != null
                      ? districts.value!.data!.districts!
                          .firstWhere(
                              (element) => element.id == formResult.districtId)
                          .name
                      : "Quận/ Huyện",
                  onTab: formResult.provinceId != null
                      ? showModalSelectDistrict
                      : null,
                  trailing: formResult.provinceId != null
                      ? const Icon(Icons.keyboard_arrow_right)
                      : null,
                ),
                ListTitleSelectOption(
                  title: wards.value != null && formResult.wardId != null
                      ? wards.value!.data!.wards!
                          .firstWhere(
                              (element) => element.id == formResult.wardId)
                          .name
                      : "Phường/ Xã",
                  onTab: formResult.districtId != null
                      ? showModalSelectWard
                      : null,
                  trailing: formResult.districtId != null
                      ? const Icon(Icons.keyboard_arrow_right)
                      : null,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
