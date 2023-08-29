import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:roomeasy/app/constant/app_color.dart';
import 'package:roomeasy/app/provider/home/home_filter_data.dart';
import 'package:roomeasy/ultils/strings.dart';

class HomeFilterRangePrice extends StatefulWidget {
  const HomeFilterRangePrice({Key? key}) : super(key: key);

  @override
  State createState() => _HomeFilterRangePriceState();
}

class _HomeFilterRangePriceState extends State<HomeFilterRangePrice> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: AppColor.darkWhiteBackground,
      constraints: const BoxConstraints(
        minHeight: 0,
        maxHeight: double.infinity,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 10, top: 5, bottom: 5),
            child: Text("Giá tiền tối đa",
                style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 16,
                    color: Colors.black54,
                    fontWeight: FontWeight.w600)),
          ),
          Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Consumer(
                  builder: (context, ref, child) => Padding(
                    padding: const EdgeInsets.only(right: 24, top: 4),
                    child: Text(
                      "${UString.getCurrentcy(ref.watch(homeFilterProvider).maxPrice)} VND",
                      style: const TextStyle(
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w400,
                          color: AppColor.orange),
                    ),
                  ),
                ),
                Consumer(
                  builder: (context, ref, child) => SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: Slider(
                        min: 1000000,
                        max: 100000000,
                        activeColor: AppColor.primary,
                        divisions: 100,
                        value:
                            ref.watch(homeFilterProvider).maxPrice.toDouble(),
                        onChanged: (double val) {
                          ref
                              .read(homeFilterProvider.notifier)
                              .setMaxPrice(val.toInt());
                        },
                        label: UString.getCurrentcy(
                            ref.watch(homeFilterProvider).maxPrice),
                      )),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
