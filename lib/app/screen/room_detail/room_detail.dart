// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:readmore/readmore.dart';

import 'package:roomeasy/api/services/room/room.dart';
import 'package:roomeasy/app/constant/app_color.dart';
import 'package:roomeasy/app/provider/room/room_detail.dart';
import 'package:roomeasy/app/widget/room_detail/room_detail_app_bar.dart';

class RoomDetailScreen extends ConsumerStatefulWidget {
  static const routeName = "/room/detail";
  final String id;
  const RoomDetailScreen({required this.id, Key? key}) : super(key: key);

  @override
  RoomDetailScreenState createState() => RoomDetailScreenState();
}

class RoomDetailScreenState extends ConsumerState<RoomDetailScreen> {
  bool isReadMore = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final room = ref.watch(roomDetailProvider(widget.id));
    final statusBarHeight = MediaQuery.of(context).padding.top;
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: const RoomDetailAppBar(mount: false),
        body: room.when(
          data: (res) {
            return LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
              final witdhScreen = constraints.maxWidth - 24;
              return Padding(
                padding: EdgeInsets.only(
                  top: statusBarHeight + 12,
                  left: 12,
                  right: 12,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      // avatar need url and some info
                      Container(
                        width: witdhScreen,
                        height: witdhScreen * 0.8,
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(
                          // TODO
                          image: const DecorationImage(
                              image: // res.data!.getAvatar() != null
                                  // ? NetworkImage(res.data!.getAvatar()!):
                                  AssetImage('assets/images/default_room.jpg'),
                              //as ImageProvider,
                              fit: BoxFit.cover),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Stack(
                          children: [
                            Positioned(
                              bottom: 0,
                              left: 0,
                              child: Container(
                                constraints: BoxConstraints(
                                    maxWidth: witdhScreen,
                                    maxHeight: witdhScreen * 0.7 * 0.5),
                                color: Colors.black38,
                                width: witdhScreen,
                                child: ListTile(
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
                                      '${res.data!.getFullNameLocation()}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge!
                                          .copyWith(
                                              fontSize: 13,
                                              color: Colors.white)),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      ListTile(
                          contentPadding:
                              const EdgeInsets.symmetric(vertical: 8),
                          title: Padding(
                            padding: const EdgeInsets.only(bottom: 16),
                            child: Text(
                              'Description',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(fontSize: 16),
                            ),
                          ),
                          subtitle: ReadMoreText(
                            res.data!.description!,
                            trimLines: 2,
                            colorClickableText: AppColor.appBlurPrimaryColor,
                            trimMode: TrimMode.Line,
                            trimCollapsedText: 'xem thêm',
                            trimExpandedText: 'ẩn bớt',
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .copyWith(fontSize: 14, color: Colors.black87),
                            moreStyle: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(fontSize: 14, color: Colors.blue),
                          )),
                      ListTile(
                        contentPadding: EdgeInsets.symmetric(vertical: 8),
                        leading: CircleAvatar(
                          backgroundImage:
                              AssetImage('assets/images/default_room.jpg'),
                        ),
                        title: Text(
                          res.data!.owner!.name!,
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(fontSize: 16),
                        ),
                        subtitle: Text(
                          'Người cho thuê',
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall!
                              .copyWith(fontSize: 12, color: Colors.black54),
                        ),
                        trailing: Icon(Icons.message),
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
