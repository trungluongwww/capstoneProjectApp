import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:roomeasy/app/constant/app_color.dart';
import 'package:roomeasy/app/provider/home/home_filter_data.dart';
import 'package:roomeasy/app/widget/home_filter/home_filter_location.dart';
import 'package:roomeasy/app/widget/home_filter/home_filter_category.dart';
import 'package:roomeasy/app/widget/home_filter/home_filter_range_price.dart';
import 'package:roomeasy/app/widget/home_filter/home_filter_sort.dart';

class HomeFilterScreen extends ConsumerStatefulWidget {
  static const routerName = '/home/filter';
  const HomeFilterScreen({Key? key}) : super(key: key);

  @override
  ConsumerState createState() => _HomeFilterScreenState();
}

class _HomeFilterScreenState extends ConsumerState<HomeFilterScreen> {
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
            title: const Text("Bộ lọc",
                style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 18,
                    color: Colors.black87,
                    fontWeight: FontWeight.w400)),
            actions: [
              TextButton(
                onPressed: () {
                  ref.watch(homeFilterProvider.notifier).reset();
                },
                child: const Text(
                  "Thiết lặp lại",
                  style: TextStyle(color: AppColor.primary),
                ),
              ),
            ],
            leading: const BackButton(color: AppColor.primary),
            backgroundColor: AppColor.white,
            elevation: 0,
          ),
          body: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
            const double applyButtonHeight = 50.0;
            return Container(
              color: AppColor.darkWhiteBackground,
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(children: const [
                        HomeFilterLocation(),
                        HomeFilterCategory(),
                        HomeFilterRangePrice(),
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
                        backgroundColor: AppColor.textBlue,
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
