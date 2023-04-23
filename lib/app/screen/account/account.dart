import 'package:flutter/material.dart';

class Account extends StatefulWidget {
  const Account({Key? key}) : super(key: key);
  static const routeName = '/account';

  @override
  _AccountState createState() => _AccountState();
}

class _AccountState extends State<Account> {
  @override
  Widget build(BuildContext context) {
    @protected
    @mustCallSuper
    void initState() {
      super.initState();

      print("init home");
    }

    return Scaffold(
      body: const Center(child: const Text('Hello world: account ')),
    );
  }
}
