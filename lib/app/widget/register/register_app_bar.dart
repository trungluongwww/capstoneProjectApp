// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:roomeasy/app/constant/app_color.dart';

class RegisterAppbar extends StatelessWidget with PreferredSizeWidget {
  final VoidCallback onSubmit;

  const RegisterAppbar({
    Key? key,
    required this.onSubmit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final appBarHeight = (screenHeight * 8 / 100).roundToDouble();
    return PreferredSize(
      preferredSize: Size.fromHeight(appBarHeight),
      child: AppBar(
        elevation: 0,
        toolbarHeight: appBarHeight,
        backgroundColor: Colors.white,
        leading: const BackButton(color: AppColor.primary),
        title: const Text(
          'Tạo tài khoản',
          style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 16,
              color: Colors.black87,
              fontWeight: FontWeight.w600),
        ),
        actions: [
          TextButton(onPressed: onSubmit, child: const Text('Đăng ký'))
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
