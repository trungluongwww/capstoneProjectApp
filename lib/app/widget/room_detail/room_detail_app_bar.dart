// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:roomeasy/app/constant/app_color.dart';
import 'package:roomeasy/app/provider/common/auth.dart';
import 'package:roomeasy/app/screen/room/room_update.dart';

class RoomDetailAppBar extends ConsumerWidget with PreferredSizeWidget {
  final String ownerId;
  final String roomId;
  const RoomDetailAppBar({
    Key? key,
    required this.ownerId,
    required this.roomId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenHeight = MediaQuery.of(context).size.height;
    final appBarHeight = (screenHeight * 8 / 100).roundToDouble();

    String? userId = ref.watch(authProfileProvider)?.id;
    return PreferredSize(
      preferredSize: Size.fromHeight(appBarHeight),
      child: AppBar(
        leading: const BackButton(color: AppColor.appPrimaryColor),
        backgroundColor: Colors.white,
        elevation: 1,
        actions: userId == ownerId
            ? [
                TextButton.icon(
                  label: const Text(
                    'Chỉnh sửa',
                    style: TextStyle(
                        color: Colors.blue,
                        fontSize: 14,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400),
                  ),
                  icon: const Icon(Icons.edit_square),
                  onPressed: () {
                    Navigator.of(context).pushReplacementNamed(
                        RoomUpdateScreen.routeName,
                        arguments: {
                          'id': roomId,
                        });
                  },
                ),
              ]
            : null,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
