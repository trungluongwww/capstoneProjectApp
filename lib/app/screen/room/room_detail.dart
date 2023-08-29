// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:readmore/readmore.dart';
import 'package:roomeasy/api/services/auth/auth.dart';

import 'package:roomeasy/app/constant/app_color.dart';
import 'package:roomeasy/app/constant/app_icon.dart';
import 'package:roomeasy/app/provider/room/room_detail.dart';
import 'package:roomeasy/app/screen/image/detail_image_path_screen.dart';
import 'package:roomeasy/app/widget/common/button_icon_primary.dart';
import 'package:roomeasy/app/widget/common/center_content_something_error.dart';
import 'package:roomeasy/app/widget/common/custom_cache_image.dart';
import 'package:roomeasy/app/widget/common/list_title_small_without_spacing.dart';
import 'package:roomeasy/app/widget/common/modal_error.dart';
import 'package:roomeasy/app/widget/profile/profile_bottom_modal.dart';
import 'package:roomeasy/app/widget/room_detail/room_detail_app_bar.dart';

class RoomDetailScreen extends ConsumerStatefulWidget {
  static const routeName = "/room/detail";
  final String id;
  const RoomDetailScreen({required this.id, Key? key}) : super(key: key);

  @override
  RoomDetailScreenState createState() => RoomDetailScreenState();
}

class RoomDetailScreenState extends ConsumerState<RoomDetailScreen> {
  // state
  bool isReadMore = false;

  bool isOpenForRent = true;

  bool isFavourited = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final room = ref.watch(roomDetailProvider(widget.id));

    return Scaffold(
        appBar: RoomDetailAppBar(
            room: room.when(
              data: (res) {
                return res.data;
              },
              error: (error, stackTrace) => null,
              loading: () => null,
            ),
            roomId: widget.id),
        body: room.when(
          data: (res) {
            if (res.data == null) {
              return const CenterContentSomethingError();
            }

            return LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
              final witdhScreen = constraints.maxWidth - 24;
              return Padding(
                padding: const EdgeInsets.only(
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
                          image: DecorationImage(
                              image: res.data!.getAvatar() != null
                                  ? NetworkImage(res.data!.getAvatar()!)
                                  : const AssetImage(
                                          'assets/images/default_room.jpg')
                                      as ImageProvider,
                              fit: BoxFit.cover),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Stack(
                          children: [
                            Positioned(
                              top: 0,
                              right: 0,
                              child: Material(
                                borderRadius: const BorderRadius.only(
                                    bottomLeft: Radius.circular(16)),
                                elevation: 1,
                                color: Colors.transparent,
                                child: InkWell(
                                  splashColor: Colors.grey,
                                  onTap: () async {
                                    if (!isFavourited) {
                                      final rs = await AuthServices()
                                          .addToFavouriteRoom(
                                              res.data?.id ?? "");
                                      if (rs.isSuccess() && mounted) {
                                        ModalError().showToast(
                                            context,
                                            rs.code.toString(),
                                            "Đã thêm vào danh sách yêu thích");
                                      }
                                    } else {
                                      AuthServices().removeFavouriteRoom(
                                          res.data!.id ?? "");
                                    }

                                    setState(() {
                                      isFavourited = !isFavourited;
                                    });
                                  },
                                  child: isFavourited
                                      ? TextButton.icon(
                                          icon: const Icon(
                                            Icons.favorite,
                                            size: 30,
                                            color: Colors.red,
                                          ),
                                          label: const Text(
                                            'Lưu',
                                            style: TextStyle(
                                                fontFamily: 'Inter',
                                                fontWeight: FontWeight.w800,
                                                fontSize: 14,
                                                color: Colors.red),
                                          ),
                                          onPressed: null,
                                        )
                                      : TextButton.icon(
                                          icon: const Icon(
                                            Icons.favorite,
                                            size: 30,
                                            color: Colors.white,
                                          ),
                                          label: const Text(
                                            'Lưu',
                                            style: TextStyle(
                                                fontFamily: 'Inter',
                                                fontWeight: FontWeight.w500,
                                                fontSize: 14,
                                                color: Colors.white),
                                          ),
                                          onPressed: null,
                                        ),
                                ),
                              ),
                            ),
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
                                    style: const TextStyle(
                                        fontFamily: 'Inter',
                                        fontSize: 18,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  subtitle: Text(
                                      '${res.data!.getFullNameLocation()}',
                                      style: const TextStyle(
                                          fontFamily: 'Inter',
                                          fontSize: 13,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w400)),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      ListTile(
                        contentPadding: const EdgeInsets.symmetric(vertical: 8),
                        leading: CircleAvatar(
                          backgroundImage:
                              // TODO
                              res.data!.owner!.avatar != null &&
                                      res.data!.owner!.avatar != ""
                                  ? NetworkImage(res.data!.owner!.avatar!)
                                  : const AssetImage(
                                          'assets/images/default_user.png')
                                      as ImageProvider,
                        ),
                        title: Text(
                          res.data!.owner!.name!,
                          style: const TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 16,
                              color: Colors.black87,
                              fontWeight: FontWeight.w500),
                        ),
                        subtitle: const Text('Người cho thuê',
                            style: TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 12,
                                color: Colors.black54,
                                fontWeight: FontWeight.w400)),
                        trailing: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: InkWell(
                                splashColor: Colors.grey,
                                child: ButtonIconFlatPrimary(
                                  size: 32,
                                  onClick: () async {
                                    showModalBottomSheet(
                                        context: context,
                                        builder: (context) =>
                                            ProfileBottomModal(
                                                userId: res.data!.owner!.id!));
                                  },
                                  icon: Icons.phone,
                                ))),
                      ),
                      Container(
                        padding: const EdgeInsets.only(top: 4, bottom: 4),
                        alignment: Alignment.centerLeft,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Thông tin',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontFamily: 'Inter',
                                    fontSize: 16,
                                    color: Colors.black87,
                                    fontWeight: FontWeight.w600)),
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
                        child: const Text('Hình ảnh thực tế',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 16,
                                color: Colors.black87,
                                fontWeight: FontWeight.w600)),
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
                        itemCount: res.data!.files.length > 4
                            ? 4
                            : res.data!.files.length,
                        itemBuilder: (BuildContext context, int index) {
                          return InkWell(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (ctx) => DetailImagePathScreen(
                                      path:
                                          res.data!.files[index].info!.url!)));
                            },
                            child: SizedBox(
                              child: Image.network(
                                res.data!.files[index].info!.url!,
                                fit: BoxFit.fill,
                              ),
                            ),
                          );
                        },
                      ),
                      ListTile(
                          contentPadding:
                              const EdgeInsets.symmetric(vertical: 8),
                          title: const Padding(
                            padding: EdgeInsets.only(bottom: 16),
                            child: Text('Mô tả chi tiết',
                                style: TextStyle(
                                    fontFamily: 'Inter',
                                    fontSize: 16,
                                    color: Colors.black87,
                                    fontWeight: FontWeight.w600)),
                          ),
                          subtitle: ReadMoreText(res.data!.description!,
                              trimLines: 2,
                              colorClickableText: AppColor.lightPrimary,
                              trimMode: TrimMode.Line,
                              trimCollapsedText: 'xem thêm',
                              trimExpandedText: 'ẩn bớt',
                              style: const TextStyle(
                                  fontFamily: 'Inter',
                                  fontSize: 14,
                                  color: Colors.black87,
                                  fontWeight: FontWeight.w400),
                              moreStyle: const TextStyle(
                                  fontFamily: 'Inter',
                                  fontSize: 14,
                                  color: AppColor.primary,
                                  fontWeight: FontWeight.w400))),
                      const Padding(
                        padding: EdgeInsets.only(top: 16, bottom: 8),
                        child: Text('Tiện ích có sẵn',
                            style: TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 16,
                                color: Colors.black87,
                                fontWeight: FontWeight.w400)),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: GridView(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          padding: EdgeInsets.zero,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 8,
                                  mainAxisSpacing: 8,
                                  childAspectRatio: 4),
                          children: res.data!.conveniences.map((conv) {
                            return Container(
                              padding: const EdgeInsets.all(4),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color: AppColor.darkWhiteBackground,
                                  border: Border.all(
                                      width: 1, color: AppColor.lightPrimary),
                                  borderRadius: BorderRadius.circular(6)),
                              child: ListTitleSmallWithoutSpacing(
                                defaultTitle: conv.name!,
                                leadIcon:
                                    AppIcon().getIconDataByKey(conv.code!) ??
                                        Icons.help_outline,
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
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
