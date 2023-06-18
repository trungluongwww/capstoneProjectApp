import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:roomeasy/api/services/room/room.dart';
import 'package:roomeasy/app/constant/app_color.dart';
import 'package:roomeasy/app/provider/home/home_filter_data.dart';
import 'package:roomeasy/app/provider/room/room.dart';
import 'package:roomeasy/app/provider/room/room_recommend.dart';
import 'package:roomeasy/app/screen/common/no_network_screen.dart';
import 'package:roomeasy/app/widget/home/home_body_recommend.dart';
import 'package:roomeasy/app/widget/room/room_container_item.dart';

class HomeBody extends ConsumerStatefulWidget {
  const HomeBody({Key? key}) : super(key: key);

  @override
  HomeBodyState createState() => HomeBodyState();
}

class HomeBodyState extends ConsumerState<HomeBody> {
  // state
  String pageToken = "";
  bool isLoading = false;
  late ScrollController _scrollController;

  Future<void> reloadRoom() async {
    if (isLoading) return;
    setState(() {
      isLoading = true;
    });

    final filter = ref.read(homeFilterProvider);

    final response = await RoomServices().getRooms(
        districtId: filter.selectedDistrictId,
        provinceId: filter.selectedProvinceId,
        wardId: filter.selectTedWardId,
        orderField: filter.sortField,
        orderValue: filter.sortValue,
        type: filter.roomType,
        keyword: filter.keyword,
        maxPrice: filter.maxPrice);

    if (response.code.toString().startsWith('2') && response.data != null) {
      ref.read(roomProvider.notifier).reset(response.data!.rooms!);
      pageToken = response.data!.pageToken ?? "";
    }
    setState(() {
      isLoading = false;
    });
  }

  Future<void> loadMore() async {
    if (isLoading || pageToken == "") return;
    setState(() {
      isLoading = true;
    });
    final filter = ref.read(homeFilterProvider);

    final response = await RoomServices().getRooms(
        districtId: filter.selectedDistrictId,
        provinceId: filter.selectedProvinceId,
        wardId: filter.selectTedWardId,
        orderField: filter.sortField,
        orderValue: filter.sortValue,
        pageToken: pageToken,
        type: filter.roomType,
        keyword: filter.keyword);

    if (response.code.toString().startsWith('2') && response.data != null) {
      ref.read(roomProvider.notifier).addToList(response.data!.rooms!);
      pageToken = response.data!.pageToken ?? "";
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    reloadRoom();
    _scrollController = ScrollController();
    _scrollController.addListener(__scrollListener);
  }

  // event lisner
  void __scrollListener() {
    if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      loadMore();
    }
  }

  @override
  Widget build(BuildContext context) {
    final rooms = ref.watch(roomProvider);

    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraint) {
      return RefreshIndicator(
          color: Colors.white,
          backgroundColor: const Color.fromARGB(110, 158, 158, 158),
          strokeWidth: 2.0,
          onRefresh: () async {
            reloadRoom();
            try {
              ref.invalidate(roomRecommendProvider);
            } catch (e) {}
          },
          child: Container(
            color: AppColor.darkWhiteBackground,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  // list room
                  child: CustomScrollView(
                    controller: _scrollController,
                    physics: const AlwaysScrollableScrollPhysics(),
                    // itemCount: rooms.length,
                    // itemBuilder: (BuildContext context, int index) {
                    // return RoomContainerItem(room: rooms[index]);
                    // },
                    slivers: [
                      SliverList(
                        delegate: SliverChildBuilderDelegate(childCount: 1,
                            (context, index) {
                          return const HomeBodyRecommend();
                        }),
                      ),
                      SliverList(
                          delegate: SliverChildBuilderDelegate(
                              childCount: rooms.length, (context, index) {
                        return RoomContainerItem(room: rooms[index]);
                      }))
                    ],
                  ),
                ),
              ],
            ),
          ));
    });
  }
}
