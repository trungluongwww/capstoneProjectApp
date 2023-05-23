import 'package:flutter/material.dart';

class CenterContentSomethingError extends StatelessWidget {
  const CenterContentSomethingError({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: const [
        Icon(
          Icons.error_outline,
          size: 40,
          color: Colors.red,
        ),
        SizedBox(
          width: 300,
          child: Text(
            'Lỗi gì đó đã xảy ra, vui lòng đóng ứng dụng và mở lại.',
            style: TextStyle(
                fontFamily: 'Inter',
                fontWeight: FontWeight.w400,
                fontSize: 16,
                color: Colors.black),
          ),
        )
      ],
    );
  }
}
