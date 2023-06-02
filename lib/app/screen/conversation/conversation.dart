import 'package:flutter/material.dart';
import 'package:roomeasy/app/constant/app_color.dart';
import 'package:roomeasy/app/widget/conversation/conversation_list_room.dart';

class Conversation extends StatefulWidget {
  const Conversation({Key? key}) : super(key: key);
  static const routeName = '/conversation';

  @override
  _ConversationState createState() => _ConversationState();
}

class _ConversationState extends State<Conversation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        backgroundColor: Colors.white,
        centerTitle: true,
        leading: const BackButton(
          color: AppColor.appPrimaryColor,
        ),
        title: const Text(
          "Tin nhắn",
          style: TextStyle(
              fontFamily: 'Inter',
              fontWeight: FontWeight.w500,
              fontSize: 16,
              color: Colors.black87),
        ),
      ),
      body: const ConversationListRoom(),
    );
  }
}
