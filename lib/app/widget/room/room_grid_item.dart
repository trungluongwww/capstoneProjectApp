// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:roomeasy/api/services/room/room.dart';
import 'package:roomeasy/app/constant/app_value.dart';
import 'package:roomeasy/form/room/room_change_status.dart';

import 'package:roomeasy/model/room/room.dart';

class RoomGridItem extends StatefulWidget {
  final VoidCallback onTab;
  final RoomModel room;
  const RoomGridItem({
    Key? key,
    required this.onTab,
    required this.room,
  }) : super(key: key);

  @override
  State<RoomGridItem> createState() => _RoomGridItemState();
}

class _RoomGridItemState extends State<RoomGridItem> {
  bool isActive = false;
  @override
  void initState() {
    isActive = widget.room.status?.key == AppValue.active;
    super.initState();
  }

  Widget _getStatusWidget() {
    if (widget.room.status?.key == AppValue.banned) {
      return Padding(
        padding: const EdgeInsets.only(left: 8.0, top: 4),
        child: Text(
          widget.room.status?.value ?? "Phòng đã bị admin khóa",
          style: const TextStyle(
              fontFamily: 'Inter',
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: Colors.red),
        ),
      );
    }

    return SwitchListTile(
      title: const Text(
        "Mở cho thuê",
        style: TextStyle(
            fontFamily: 'Inter',
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: Colors.black54),
      ),
      contentPadding: const EdgeInsets.only(left: 8),
      value: isActive,
      onChanged: (val) async {
        final res = await RoomServices().changeStatus(
            roomId: widget.room.id!,
            formdata: RoomChangeStatusFormModel(
                status: val ? AppValue.active : AppValue.inactive));
        if (res.isSuccess()) {
          setState(() {
            isActive = !isActive;
          });
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 1,
      borderRadius: BorderRadius.circular(8),
      clipBehavior: Clip.hardEdge,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Flexible(
            flex: 3,
            child: SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: Image.asset(
                'assets/images/default_room.jpg',
                fit: BoxFit.cover,
              ),
            )),
        Flexible(flex: 1, child: _getStatusWidget()),
        Flexible(
          flex: 3,
          child: InkWell(
            splashColor: Colors.grey,
            onTap: widget.onTab,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // FittedBox(
                  //   fit: BoxFit.scaleDown,
                  //   child: Text(
                  //     room.status!.value ?? "",
                  //     style: const TextStyle(
                  //         fontSize: 12,
                  //         fontFamily: 'Inter',
                  //         fontWeight: FontWeight.w300,
                  //         color: Colors.grey),
                  //   ),
                  // ),
                  Text(
                    widget.room.name ?? "",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 14,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    '${widget.room.rentPerMonth?.toString() ?? "0đ"} VND',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 12,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w500,
                      color: Colors.blue,
                    ),
                  ),
                  Text(
                    widget.room.getFullNameLocation() ?? "",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 12,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w500,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
      ]),
    );
  }
}
