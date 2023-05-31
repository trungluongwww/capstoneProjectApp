// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:roomeasy/model/conversation/conversation.dart';
import 'package:roomeasy/ultils/strings.dart';

class ConversationListItem extends StatelessWidget {
  final ConversationModel conv;
  final String userId;
  const ConversationListItem({
    Key? key,
    required this.conv,
    required this.userId,
  }) : super(key: key);

  String _getNameRoom() {
    if (userId == conv.owner!.id) {
      return conv.participant!.name ?? "Không xác định";
    }

    return conv.owner!.name ?? "Không xác định";
  }

  String _getContentLastMessage() {
    if (conv.lastMessage == null) {
      return "Chưa có tin nhắn";
    }

    return "${userId == conv.lastSenderId ? "Bạn" : _getNameRoom()}: ${conv.lastMessage!.content}";
  }

  String _getUpdated() {
    if (conv.lastMessage?.updatedAt != null) {
      return UString.getShortTime(conv.lastMessage!.updatedAt!);
    }

    return UString.getShortTime(conv.updatedAt!);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      splashColor: Colors.grey,
      child: SizedBox(
        width: 70,
        height: 70,
        child: ListTile(
          title: Text(
            _getNameRoom(),
            style: const TextStyle(
                fontFamily: 'Inter',
                fontWeight: FontWeight.w500,
                fontSize: 16,
                color: Colors.black87),
          ),
          subtitle: Text(
            _getContentLastMessage(),
            style: const TextStyle(
                overflow: TextOverflow.ellipsis,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w300,
                fontSize: 14,
                color: Colors.black87),
          ),
          leading: const SizedBox(
            width: 50,
            height: 50,
            child: CircleAvatar(
              // todo set avatar
              backgroundImage: AssetImage('assets/images/default_user.png'),
            ),
          ),
          trailing: Text(
            _getUpdated(),
            style: const TextStyle(
                fontFamily: 'Inter',
                fontWeight: FontWeight.w300,
                fontSize: 12,
                color: Colors.black87),
          ),
        ),
      ),
    );
  }
}
