import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:roomeasy/app/constant/app_color.dart';
import 'package:roomeasy/app/provider/home/home_filter_data.dart';
import 'package:roomeasy/app/provider/home/location.dart';
import 'package:roomeasy/app/screen/home_filter/home_filter_category.dart';
import 'package:roomeasy/app/screen/home_filter/home_filter_location.dart';
import 'package:roomeasy/app/screen/home_filter/home_filter_sort.dart';
import 'package:roomeasy/model/location/district.dart';
import 'package:roomeasy/model/location/province.dart';
import 'package:roomeasy/model/location/ward.dart';
import 'package:roomeasy/model/response/response.dart';

class HomeFilter extends ConsumerStatefulWidget {
  static const routerName = '/home/filter';
  const HomeFilter({Key? key}) : super(key: key);

  @override
  _HomeFilterState createState() => _HomeFilterState();
}

class _HomeFilterState extends ConsumerState<HomeFilter> {
  int? selectTedProvinceIndex;
  int? selectTedDistrictIndex;
  int? selectTedWardIndex;

  late List<ProvinceModel>? provinces;
  late List<DistrictModel>? districts;
  late List<WardModel>? wards;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context, false);
        return true;
      },
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            title: Text(
              "Bộ lọc",
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(color: AppColor.appTextDefaultColor, fontSize: 18),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  ref.watch(homeFilterProvider.notifier).reset();
                },
                child: const Text(
                  "Thiết lặp lại",
                  style: TextStyle(color: AppColor.appPrimaryColor),
                ),
              ),
            ],
            leading: const BackButton(color: AppColor.appPrimaryColor),
            backgroundColor: AppColor.appBackgroundColor,
            elevation: 0,
          ),
          body: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
            const double applyButtonHeight = 50.0;
            return Container(
              color: AppColor.appDarkWhiteColor,
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(children: const [
                        HomeFilterLocation(),
                        HomeFilterCategory(),
                        HomeFilterSort(),
                      ]),
                    ),
                  ),
                  SizedBox(
                    height: applyButtonHeight,
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero,
                        ),
                        backgroundColor: Colors.blue,
                      ),
                      onPressed: () async {
                        Navigator.pop(context, true);
                      },
                      child: const Text('Áp dụng'),
                    ),
                  )
                ],
              ),
            );
          })),
    );
  }
}