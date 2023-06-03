// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:roomeasy/app/constant/app_type.dart';
import 'package:roomeasy/app/widget/common/cache_image_contain.dart';

import 'package:roomeasy/model/message/message.dart';
import 'package:roomeasy/ultils/strings.dart';

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
    Widget getContent() {
      Widget? content;
      switch (message.type) {
        case AppType.photo:
          content = CacheImageContain(
            url: message.file!.url!,
          );
          break;
        default:
          content = Text(
            message.content ?? "",
            style: TextStyle(
                fontSize: 14,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w400,
                color:
                    userId == message.authorId ? Colors.white : Colors.black),
          );
      }

      return Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          content,
          Text(UString.getTimeWithoutDate(message.createdAt!),
              style: TextStyle(
                  fontSize: 12,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w300,
                  color: userId == message.authorId
                      ? Colors.white
                      : Colors.black)),
        ],
      );
    }

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
            child: getContent()),
      ),
    );
  }
}
