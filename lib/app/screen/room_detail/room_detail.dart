// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:readmore/readmore.dart';

import 'package:roomeasy/api/services/room/room.dart';
import 'package:roomeasy/app/constant/app_color.dart';
import 'package:roomeasy/app/provider/room/room_detail.dart';
import 'package:roomeasy/app/widget/common/button_icon_linear_primary.dart';
import 'package:roomeasy/app/widget/common/button_icon_primary.dart';
import 'package:roomeasy/app/widget/common/list_title_small_without_spacing.dart';
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
                        contentPadding: const EdgeInsets.symmetric(vertical: 8),
                        // TODO: set avatar
                        leading: CircleAvatar(
                          backgroundImage: res.data!.owner!.avatar != null &&
                                  res.data!.owner!.avatar != ""
                              ? NetworkImage(res.data!.owner!.avatar!)
                              : const AssetImage(
                                      'assets/images/default_room.jpg')
                                  as ImageProvider,
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
                        trailing: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Material(
                              child: InkWell(
                                  child: ButtonIconFlatPrimary(
                            size: 32,
                            onClick: () {
                              debugPrint(DateTime.now().toIso8601String());
                            },
                            icon: Icons.chat,
                          ))),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(top: 4, bottom: 4),
                        alignment: Alignment.centerLeft,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Thông tin',
                              textAlign: TextAlign.left,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(fontSize: 16),
                            ),
                            ListTitleSmallWithoutSpacing(
                                colorLeadIcon: Colors.red,
                                title: res.data!.status!.value,
                                prefixTitle: "Trạng thái",
                                defaultTitle: "Liên hệ người đăng",
                                leadIcon: Icons.info_outline),
                            ListTitleSmallWithoutSpacing(
                                title: res.data!.type!.value,
                                prefixTitle: "Loại cho thuê",
                                defaultTitle: "Liên hệ người đăng",
                                leadIcon: Icons.house_outlined),
                            ListTitleSmallWithoutSpacing(
                                prefixTitle: "Tiền thuê/ tháng",
                                colorLeadIcon: Colors.green.shade800,
                                colorTitleIcon: Colors.green.shade800,
                                title: NumberFormat("#,##0", "es_US")
                                    .format(res.data!.rentPerMonth),
                                defaultTitle: "Liên hệ người đăng",
                                leadIcon: Icons.attach_money_outlined),
                            ListTitleSmallWithoutSpacing(
                                prefixTitle: "Tiền cọc",
                                colorLeadIcon: Colors.amber,
                                colorTitleIcon: Colors.amber,
                                title: NumberFormat("#,##0", "es_US")
                                    .format(res.data!.deposit),
                                defaultTitle: "Liên hệ người đăng",
                                leadIcon: Icons.local_atm),
                            if (res.data!.squareMetre != null)
                              ListTitleSmallWithoutSpacing(
                                  prefixTitle: "Diện tích",
                                  title:
                                      '${res.data!.squareMetre.toString()} m²',
                                  defaultTitle: "",
                                  leadIcon: Icons.straighten)
                          ],
                        ),
                      ),

                      Container(
                        padding: const EdgeInsets.only(top: 4, bottom: 4),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Hình ảnh thực tế',
                          textAlign: TextAlign.left,
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(fontSize: 16),
                        ),
                      ),
                      GridView.builder(
                        padding: const EdgeInsets.only(top: 16, bottom: 16),
                        shrinkWrap: true,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisSpacing: 16,
                                mainAxisSpacing: 4,
                                childAspectRatio: 1,
                                crossAxisCount: 4),
                        itemCount: res.data!.files!.length > 4
                            ? 4
                            : res.data!.files!.length,
                        itemBuilder: (BuildContext context, int index) {
                          return SizedBox(
                            child: Image.network(
                              res.data!.files![index].info!.url!,
                              fit: BoxFit.fill,
                            ),
                          );
                        },
                      ),
                      ListTile(
                          contentPadding:
                              const EdgeInsets.symmetric(vertical: 8),
                          title: Padding(
                            padding: const EdgeInsets.only(bottom: 16),
                            child: Text(
                              'Mô tả chi tiết',
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
