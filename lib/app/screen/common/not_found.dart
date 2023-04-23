import 'package:flutter/material.dart';

class NotFoundScreen extends StatelessWidget {
  const NotFoundScreen({Key? key}) : super(key: key);

  final title = 'Not found';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Text(title),
    ));
  }
}
