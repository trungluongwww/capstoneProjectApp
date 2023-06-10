import 'package:flutter/material.dart';
import 'package:roomeasy/api/services/auth/auth.dart';
import 'package:roomeasy/app/constant/app_color.dart';
import 'package:roomeasy/app/screen/room/room_detail.dart';
import 'package:roomeasy/app/widget/common/modal_error.dart';
import 'package:roomeasy/app/widget/room/room_grid_item.dart';
import 'package:roomeasy/model/room/room.dart';

class TabRoom extends StatefulWidget {
  const TabRoom({Key? key}) : super(key: key);

  @override
  State createState() => _TabRoomState();
}

class _TabRoomState extends State<TabRoom> {
  // state
  List<RoomModel> _rooms = [];
  bool isRoomLoading = false;
  String _pageToken = "";

  late ScrollController _scrollController;

  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);

    _refreshRoom();
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  // fetch
  Future<void> _refreshRoom() async {
    setState(() {
      isRoomLoading = true;
    });
    _pageToken = "";
    final res = await AuthServices().getMyRooms(_pageToken);
    if (!res.code.toString().startsWith('2')) {
      if (mounted) {
        ModalError().showToast(context, res.code.toString(), res.message ?? "");
      }
    }

    if (res.data == null) {
      return;
    }

    _pageToken = res.data!.pageToken ?? "";

    setState(() {
      _rooms = res.data!.rooms ?? [];
      isRoomLoading = false;
    });
  }

  Future<void> _loadMoreRoom() async {
    if (_pageToken.isNotEmpty) {
      setState(() {
        isRoomLoading = true;
      });

      final res = await AuthServices().getMyRooms(_pageToken);
      if (!res.code.toString().startsWith('2') || res.data == null) {
        if (mounted) {
          ModalError()
              .showToast(context, res.code.toString(), res.message ?? "");
        }
      }

      _pageToken = res.data!.pageToken ?? "";

      setState(() {
        _rooms.addAll(res.data!.rooms ?? []);
        isRoomLoading = false;
      });
    }
  }

  // event lisner
  void _scrollListener() {
    if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      _loadMoreRoom();
    }
  }

  // handler

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      RefreshIndicator(
        onRefresh: _refreshRoom,
        color: Colors.white,
        backgroundColor: const Color.fromARGB(110, 158, 158, 158),
        strokeWidth: 2.0,
        child: Container(
          color: AppColor.darkWhiteBackground,
          padding: const EdgeInsets.only(top: 8, left: 8, right: 8),
          child: GridView.builder(
            itemCount: _rooms.length,
            controller: _scrollController,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.8,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8),
            itemBuilder: (context, index) {
              return RoomGridItem(
                room: _rooms[index],
                onTab: () {
                  if (_rooms[index].id != null) {
                    Navigator.of(context).pushNamed(RoomDetailScreen.routeName,
                        arguments: {'id': _rooms[index].id});
                  }
                },
              );
            },
          ),
        ),
      ),
    ]);
  }
}
