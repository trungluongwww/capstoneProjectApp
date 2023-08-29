import 'package:flutter/material.dart';

class NoNetworkScreen extends StatelessWidget {
  static const String routerName = "/not-found";
  const NoNetworkScreen({Key? key}) : super(key: key);

  final title = 'Not found';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: SizedBox(
            width: 200,
            height: 200,
            child: Image.asset('assets/images/logo_main.png'),
          ),
        ),
        const Center(
          child: Icon(
            Icons.warning,
            size: 24,
            color: Colors.red,
          ),
        ),
        const Text(
          'Hệ thống đang gặp trục trặc',
          style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 18,
              color: Colors.amber,
              fontWeight: FontWeight.w700),
        ),
        const Text(
          'Vui lòng kiểm tra kết nối và khởi động lại ứng dụng sau',
          textAlign: TextAlign.center,
          style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 14,
              color: Colors.black54,
              fontWeight: FontWeight.w700),
        ),
      ],
    ));
  }
}
