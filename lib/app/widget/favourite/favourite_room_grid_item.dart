// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:roomeasy/app/constant/app_value.dart';
import 'package:roomeasy/model/room/room.dart';

class FavouriteRoomGridItem extends StatefulWidget {
  final VoidCallback onTab;
  final RoomModel room;
  final VoidCallback unlike;
  const FavouriteRoomGridItem({
    Key? key,
    required this.onTab,
    required this.room,
    required this.unlike,
  }) : super(key: key);

  @override
  State<FavouriteRoomGridItem> createState() => _FavouriteRoomGridItemState();
}

class _FavouriteRoomGridItemState extends State<FavouriteRoomGridItem> {
  bool isActive = false;
  @override
  void initState() {
    isActive = widget.room.status?.key == AppValue.active;
    super.initState();
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
        Flexible(
            flex: 1,
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 8),
              title: Text(
                widget.room.status?.value ?? "Liên hệ chủ",
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 12,
                    fontWeight: FontWeight.w300,
                    color: Colors.amber),
              ),
              trailing: IconButton(
                  onPressed: widget.unlike,
                  icon: const Icon(
                    Icons.favorite,
                    size: 16,
                    color: Colors.red,
                  )),
            )),
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
