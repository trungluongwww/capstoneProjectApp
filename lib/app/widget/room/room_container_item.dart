// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:roomeasy/app/constant/app_color.dart';
import 'package:roomeasy/app/screen/room/room_detail.dart';
import 'package:roomeasy/app/widget/common/list_title_small_without_spacing.dart';
import 'package:roomeasy/model/room/room.dart';
import 'package:roomeasy/ultils/strings.dart';

class RoomContainerItem extends StatelessWidget {
  final RoomModel room;
  const RoomContainerItem({
    Key? key,
    required this.room,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        onTap: () {
          if (room.id != null) {
            Navigator.of(context).pushNamed(RoomDetailScreen.routeName,
                arguments: {'id': room.id});
          }
        },
        child: Container(
          color: AppColor.appBackgroundColor,
          padding: const EdgeInsets.all(12),
          width: double.infinity,
          height: 400,
          margin: const EdgeInsets.only(bottom: 8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // list image
              Container(
                  clipBehavior: Clip.hardEdge,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                  ),
                  width: double.infinity,
                  height: 200,
                  child: room.files.isEmpty
                      ? Image.asset(
                          "assets/images/default_room.jpg",
                          fit: BoxFit.cover,
                        )
                      : Image.asset(
                          //TODO
                          // room.files[0].info!.url ??
                          "assets/images/default_room.jpg",
                          fit: BoxFit.cover,
                        )),
              // infomation
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Stack(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          room.name!,
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(
                                  fontSize: 16,
                                  overflow: TextOverflow.ellipsis),
                        ),
                        ListTitleSmallWithoutSpacing(
                            title: room.type!.value,
                            prefixTitle: "Loại cho thuê",
                            defaultTitle: "Liên hệ người đăng",
                            leadIcon: Icons.house_outlined),
                        ListTitleSmallWithoutSpacing(
                          title: room.province != null
                              ? room.getShortLocation()
                              : null,
                          defaultTitle: "Liên hệ người đăng",
                          leadIcon: Icons.location_on_sharp,
                          colorLeadIcon: Colors.red,
                        ),
                        ListTitleSmallWithoutSpacing(
                            prefixTitle: "Tiền thuê/ tháng",
                            colorLeadIcon: Colors.green.shade800,
                            colorTitleIcon: Colors.green.shade800,
                            title: NumberFormat("#,##0", "es_US")
                                .format(room.rentPerMonth),
                            defaultTitle: "Liên hệ người đăng",
                            leadIcon: Icons.attach_money_outlined),
                        if (room.squareMetre != null)
                          ListTitleSmallWithoutSpacing(
                              prefixTitle: "Diện tích",
                              title: '${room.squareMetre.toString()} m²',
                              defaultTitle: "",
                              leadIcon: Icons.straighten),
                      ],
                    ),
                    if (room.createdAt != null)
                      Positioned(
                        right: 2,
                        bottom: 0,
                        child: Text(
                          'Cập nhật ${UString.convertDateTimeToDescription(room.updatedAt!)}',
                          style: const TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 12,
                              fontWeight: FontWeight.w300,
                              color: Colors.black54),
                        ),
                      ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
