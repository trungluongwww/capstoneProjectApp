// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:roomeasy/api/services/room/room.dart';
import 'package:roomeasy/app/provider/room/room_detail.dart';
import 'package:roomeasy/app/widget/room_detail/room_detail_app_bar.dart';

class RoomDetailScreen extends ConsumerWidget {
  static const routeName = "/room/detail";
  final String id;
  const RoomDetailScreen({required this.id, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final room = ref.watch(roomDetailProvider(id));
    final statusBarHeight = MediaQuery.of(context).padding.top;
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: const RoomDetailAppBar(mount: false),
        body: room.when(
          data: (res) {
            return LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
              final witdhScreen = constraints.maxWidth - 16;
              return Padding(
                padding: EdgeInsets.only(
                  top: statusBarHeight + 8,
                  left: 8,
                  right: 8,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      // avatar need url and some info
                      Container(
                        // rectangle avatar room
                        width: witdhScreen,
                        height: witdhScreen * 0.7,
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(
                          image: const DecorationImage(
                              image: //res.data!.files!.isNotEmpty
                                  //? NetworkImage(res.data!.files![0].info!.url!):
                                  AssetImage(
                                      'assets/images/default_room.jpg'), // as ImageProvider
                              fit: BoxFit.cover),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            ListTile(
                              title: Text(
                                res.data!.name!,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge!
                                    .copyWith(
                                        color: Colors.white, fontSize: 18),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              subtitle: Text(
                                  '${res.data!.province!.name}, ${res.data!.district!.name}, ${res.data!.ward!.name},${res.data!.address}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(
                                          fontSize: 13, color: Colors.white)),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            });
          },
          error: (error, stackTrace) {
            return const Center(
              child: Text("Not found data"),
            );
          },
          loading: () {
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ));
  }
}
