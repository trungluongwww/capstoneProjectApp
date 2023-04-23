import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  static const String routeName = '/';
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @protected
  @mustCallSuper
  void initState() {
    super.initState();

    print("init home");
  }

  @override
  Widget build(BuildContext context) {
    print("init home");

    return const Scaffold(
      body: const Center(child: const Text('Home')),
    );
  }
}
