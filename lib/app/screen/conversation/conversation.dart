import 'package:flutter/material.dart';

class Conversation extends StatefulWidget {
  const Conversation({Key? key}) : super(key: key);
  static const routeName = '/conversation';

  @override
  _ConversationState createState() => _ConversationState();
}

class _ConversationState extends State<Conversation> {
  @protected
  @mustCallSuper
  void initState() {
    super.initState();

    print("init conversation");
  }

  @override
  Widget build(BuildContext context) {
    print("init conv");

    return Scaffold(
      body: const Center(child: const Text('Hello world : conversation ')),
    );
  }
}
