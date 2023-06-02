// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:roomeasy/model/message/message.dart';

class ConversationItemMessage extends StatelessWidget {
  final double maxWidth;
  final MessageModel message;
  final String userId;

  const ConversationItemMessage({
    Key? key,
    required this.maxWidth,
    required this.message,
    required this.userId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 14, right: 14, top: 10, bottom: 10),
      child: Align(
        alignment: (userId != message.authorId
            ? Alignment.topLeft
            : Alignment.topRight),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: (userId != message.authorId ? Colors.white : Colors.blue),
          ),
          padding: const EdgeInsets.all(8),
          child: Text(
            message.content ?? "",
            style: TextStyle(
                fontSize: 14,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w400,
                color:
                    userId == message.authorId ? Colors.white : Colors.black),
          ),
        ),
      ),
    );
  }
}
