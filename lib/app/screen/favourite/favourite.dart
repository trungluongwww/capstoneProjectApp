import 'package:flutter/material.dart';

class Favourite extends StatefulWidget {
  const Favourite({Key? key}) : super(key: key);
  static const routeName = '/favourite';

  @override
  _FavouriteState createState() => _FavouriteState();
}

class _FavouriteState extends State<Favourite> {
  @protected
  @mustCallSuper
  void initState() {
    super.initState();

    print("init home");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(child: const Text('hello world: favourite')),
    );
  }
}
