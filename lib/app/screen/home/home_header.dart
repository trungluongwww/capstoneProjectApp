import 'package:flutter/material.dart';
import 'package:roomeasy/api/services/room/room.dart';
import 'package:roomeasy/app/screen/home_filter/home_filter.dart';
import 'package:roomeasy/app/widget/button/primary_icon_button.dart';
import 'package:roomeasy/app/widget/input/searchbar.dart';

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

    var filters = await RoomServices().getFilters();
  }

  @override
  Widget build(BuildContext context) {
    const heightWidget = 40.0;
    const paddingVal = 10.0;
    return Padding(
        padding: const EdgeInsets.only(
          top: paddingVal,
          bottom: paddingVal,
        ),
        child: LayoutBuilder(
          builder: (BuildContext ctx, BoxConstraints constraints) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: (constraints.maxWidth - paddingVal - 50),
                  height: heightWidget,
                  child: SearchBar(
                      onSubmited: _searchBarSubmitted,
                      searchController: _searchController,
                      hintText: searchTitle),
                ),
                PrimaryIconButton(
                    size: heightWidget,
                    onClick: () => _onPressFilterButton(context))
              ],
            );
          },
        ));
  }
}
