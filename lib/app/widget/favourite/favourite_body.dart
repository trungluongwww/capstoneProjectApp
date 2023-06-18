import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:roomeasy/api/services/auth/auth.dart';
import 'package:roomeasy/app/constant/app_color.dart';
import 'package:roomeasy/app/provider/common/auth.dart';
import 'package:roomeasy/app/provider/common/bottom_navbar_index.dart';
import 'package:roomeasy/app/screen/common/no_network_screen.dart';
import 'package:roomeasy/app/screen/room/room_detail.dart';
import 'package:roomeasy/app/widget/common/modal_error.dart';
import 'package:roomeasy/app/widget/favourite/favourite_room_grid_item.dart';
import 'package:roomeasy/model/room/room.dart';

class FavouriteBody extends ConsumerStatefulWidget {
  const FavouriteBody({Key? key}) : super(key: key);

  @override
  ConsumerState createState() => _FavouriteBodyState();
}

class _FavouriteBodyState extends ConsumerState<FavouriteBody> {
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
    final res = await AuthServices().getFavouriteRooms(_pageToken);
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

    if (res.code.toString().startsWith('5')) {
      if (mounted) {
        Navigator.of(context).pushNamedAndRemoveUntil(
            NoNetworkScreen.routerName, (Route route) => false);
      }
    }
  }

  Future<void> _loadMoreRoom() async {
    if (_pageToken.isNotEmpty) {
      setState(() {
        isRoomLoading = true;
      });

      final res = await AuthServices().getFavouriteRooms(_pageToken);
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
    ref.listen(authProfileProvider, (previous, next) {
      if (next != null) {
        _refreshRoom();
      }
    });
    return Stack(children: [
      RefreshIndicator(
        onRefresh: _refreshRoom,
        color: Colors.white,
        backgroundColor: const Color.fromARGB(110, 158, 158, 158),
        strokeWidth: 2.0,
        child: Padding(
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
              return FavouriteRoomGridItem(
                room: _rooms[index],
                onTab: () {
                  if (_rooms[index].id != null) {
                    Navigator.of(context).pushNamed(RoomDetailScreen.routeName,
                        arguments: {'id': _rooms[index].id});
                  }
                },
                unlike: () {
                  AuthServices()
                      .removeFavouriteRoom(_rooms[index].id ?? "")
                      .then((value) {
                    if (value.isSuccess() && mounted) {
                      ModalError().showToast(context, value.code.toString(),
                          'Đã xóa khỏi danh sách yêu thích');
                    }
                  });

                  setState(() {
                    _rooms.removeAt(index);
                  });
                },
              );
            },
          ),
        ),
      ),
      if (_rooms.isEmpty)
        const Positioned.fill(
            child: Center(
          child: Text(
            'Không có phòng yêu thích',
            style: TextStyle(
                fontFamily: 'Inter',
                fontWeight: FontWeight.w400,
                fontSize: 16,
                color: AppColor.textBlue),
          ),
        ))
    ]);
  }
}
