import 'package:flutter/material.dart';
import 'package:roomeasy/app/constant/app_color.dart';
import 'package:roomeasy/app/widget/favourite/favourite_body.dart';

class Favourite extends StatefulWidget {
  const Favourite({Key? key}) : super(key: key);
  static const routeName = '/favourite';

  @override
  _FavouriteState createState() => _FavouriteState();
}

class _FavouriteState extends State<Favourite> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: const BackButton(color: AppColor.textBlue),
        title: const Text(
          'Danh sách yêu thích',
          style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: Colors.black87),
        ),
        centerTitle: true,
      ),
      body: const FavouriteBody(),
    );
  }
}
