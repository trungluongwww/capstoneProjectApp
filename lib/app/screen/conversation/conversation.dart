import 'package:flutter/material.dart';
import 'package:roomeasy/app/constant/app_color.dart';
import 'package:roomeasy/app/widget/conversation/conversation_list.dart';

class Conversation extends StatefulWidget {
  const Conversation({Key? key}) : super(key: key);
  static const routeName = '/conversation';

  @override
  State createState() => _ConversationState();
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
          color: AppColor.textBlue,
        ),
        title: const Text(
          "Tin nhắn",
          style: TextStyle(
              fontFamily: 'Inter',
              fontWeight: FontWeight.w500,
              fontSize: 16,
              color: AppColor.textBlue),
        ),
      ),
      body: const ConversationList(),
    );
  }
}
