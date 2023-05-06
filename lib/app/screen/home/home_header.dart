import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:roomeasy/app/constant/app_color.dart';
import 'package:roomeasy/app/provider/home/home_filter_data.dart';
import 'package:roomeasy/app/screen/home_filter/home_filter.dart';
import 'package:roomeasy/app/widget/common/button_icon_primary.dart';
import 'package:roomeasy/app/widget/common/text_field_search_with_icon.dart';

class HomeHeader extends StatefulWidget {
  const HomeHeader({Key? key}) : super(key: key);

  @override
  _HomeHeaderState createState() => _HomeHeaderState();
}

class _HomeHeaderState extends State<HomeHeader> {
  late TextEditingController _searchController;
  final String searchTitle = "Tìm kiếm";
  @override
  void initState() {
    super.initState();

    _searchController = TextEditingController();
  }

  // search submited
  void _searchBarSubmitted() {}

  Future<void> _onPressFilterButton(BuildContext context) async {
    bool? ischanged =
        await Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return const HomeFilter();
    }));
  }

  @override
  Widget build(BuildContext context) {
    const heightWidget = 40.0;
    const paddingVal = 10.0;
    return Padding(
        padding: const EdgeInsets.only(
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
                          hintText: searchTitle),
                    ),
                    ButtonIconPrimary(
                        size: heightWidget,
                        onClick: () => _onPressFilterButton(context))
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
