// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:roomeasy/app/constant/app_color.dart';
import 'package:roomeasy/app/provider/home/home_filter_data.dart';
import 'package:roomeasy/app/screen/home_filter/home_filter.dart';
import 'package:roomeasy/app/widget/common/button_icon_primary.dart';
import 'package:roomeasy/app/widget/common/text_field_search_with_icon.dart';
import 'package:roomeasy/app/widget/home/home_body.dart';

class HomeHeader extends ConsumerStatefulWidget {
  final GlobalKey<HomeBodyState> bodyKey;
  const HomeHeader({required this.bodyKey, Key? key}) : super(key: key);

  @override
  _HomeHeaderState createState() => _HomeHeaderState();
}

class _HomeHeaderState extends ConsumerState<HomeHeader> {
  late TextEditingController _searchController;
  final String searchTitle = "Tìm kiếm";
  final heightWidget = 40.0;
  final paddingVal = 10.0;
  @override
  void initState() {
    super.initState();

    _searchController = TextEditingController();
  }

  // search submited
  void _searchBarSubmitted() {
    widget.bodyKey.currentState?.reloadRoom();
  }

  @override
  Widget build(BuildContext context) {
    void onPressFilterButton() async {
      bool isChanged = await Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) {
        return const HomeFilterScreen();
      }));

      if (isChanged) {
        widget.bodyKey.currentState?.reloadRoom();
      }
    }

    return Padding(
        padding: EdgeInsets.only(
            top: paddingVal, bottom: paddingVal, left: 15, right: 15),
        child: LayoutBuilder(
          builder: (BuildContext ctx, BoxConstraints constraints) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: (constraints.maxWidth - paddingVal - 50),
                      height: heightWidget,
                      child: TextFieldSearchWithIcon(
                          onSubmited: _searchBarSubmitted,
                          searchController: _searchController,
                          onChanged: (value) {
                            ref
                                .read(homeFilterProvider.notifier)
                                .setKeyword(value);
                            debugPrint(DateTime.now().toIso8601String());
                          },
                          hintText: searchTitle),
                    ),
                    Consumer(
                      builder: (context, ref, child) {
                        return ButtonIconPrimary(
                            size: heightWidget, onClick: onPressFilterButton);
                      },
                    )
                  ],
                ),
                Consumer(
                  builder: (context, ref, child) {
                    final homeFilter = ref.watch(homeFilterProvider);
                    String locationName = [
                      homeFilter.provinceName,
                      homeFilter.districtName,
                      homeFilter.wardName
                    ].where((e) => e != null).join(", ");

                    return Text(
                      "Địa điểm: ${locationName != '' ? locationName : 'chưa chọn'}",
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: AppColor.appTextBlurColor,
                          overflow: TextOverflow.ellipsis),
                    );
                  },
                )
              ],
            );
          },
        ));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _searchController.dispose();
  }
}
