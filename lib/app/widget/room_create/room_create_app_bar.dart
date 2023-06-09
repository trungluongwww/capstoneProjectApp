import 'package:flutter/material.dart';
import 'package:roomeasy/app/constant/app_color.dart';

class RoomCreateAppBar extends StatelessWidget with PreferredSizeWidget {
  const RoomCreateAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final appBarHeight = (screenHeight * 8 / 100).roundToDouble();
    return PreferredSize(
      preferredSize: Size.fromHeight(appBarHeight),
      child: AppBar(
        leading: const BackButton(color: AppColor.primary),
        title: const Text('Đăng tin phòng',
            style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 16,
                color: Colors.black87,
                fontWeight: FontWeight.w700)),
        backgroundColor: Colors.white,
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(0.5),
          child: Container(
            color: Colors.grey, // Màu của bottom border
            height: 0.5,
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
