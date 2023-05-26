// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class DetailImagePathScreen extends StatelessWidget {
  final String path;
  const DetailImagePathScreen({
    Key? key,
    required this.path,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Image image = Image.network(path);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Hình ảnh'),
        backgroundColor: Colors.black,
        leading: const BackButton(
          color: Colors.white,
        ),
      ),
      body: GestureDetector(
        onTap: () {},
        child: Container(
          color: Colors.black,
          child: Center(child: image),
        ),
      ),
    );
  }
}
