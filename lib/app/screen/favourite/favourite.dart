import 'package:flutter/material.dart';

class Favourite extends StatefulWidget {
  const Favourite({Key? key}) : super(key: key);
  static const routeName = '/favourite';

  @override
  _FavouriteState createState() => _FavouriteState();
}

class _FavouriteState extends State<Favourite> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: const BackButton(color: Colors.blue),
        ),
        body: const Center(child: const Text('hello world: favourite')),
      ),
    );
  }
}
