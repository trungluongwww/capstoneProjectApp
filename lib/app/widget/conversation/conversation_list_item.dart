// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:roomeasy/app/screen/conversation/conversation_detail.dart';

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

  String _getAuthorNameLastMessagename() {
    if (userId == conv.lastSenderId) {
      return "Bạn";
    }

    if (conv.owner?.id == conv.lastSenderId) {
      return conv.owner!.name ?? "Không xác định";
    }

    return conv.participant!.name ?? "Không xác định";
  }

  String _getContentLastMessage() {
    if (conv.lastMessage == null) {
      return "Chưa có tin nhắn";
    }

    return "${_getAuthorNameLastMessagename()}: ${conv.lastMessage!.content}";
  }

  String _getUpdated() {
    if (conv.lastMessage?.updatedAt != null) {
      return UString.getShortTime(conv.lastMessage!.updatedAt!);
    }

    return UString.getShortTime(conv.updatedAt!);
  }

  Color _getTextColor() {
    if (conv.lastSenderId == userId ||
        conv.unread == null ||
        conv.unread! <= 0) {
      return Colors.black87;
    }

    return Colors.black;
  }

  FontWeight _getFontWeight() {
    if (conv.lastSenderId == userId ||
        conv.unread == null ||
        conv.unread! <= 0) {
      return FontWeight.w300;
    }

    return FontWeight.w500;
  }

  ImageProvider _getImageProvider() {
    NetworkImage? image;
    if (userId == conv.owner?.id &&
        conv.participant!.avatar != null &&
        conv.participant!.avatar!.isNotEmpty) {
      image = NetworkImage(conv.participant!.avatar!);
    } else if (userId == conv.participant?.id &&
        conv.owner!.avatar != null &&
        conv.owner!.avatar!.isNotEmpty) {
      image = NetworkImage(conv.owner!.avatar!);
    }

    return image != null
        ? image as ImageProvider
        : const AssetImage('assets/images/default_user.png');
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context)
            .pushNamed(ConversationDetail.routeName, arguments: {
          "id": conv.id,
        });
      },
      splashColor: Colors.grey,
      child: SizedBox(
        width: 70,
        height: 70,
        child: ListTile(
          title: Text(
            _getNameRoom(),
            style: TextStyle(
                fontFamily: 'Inter',
                fontWeight: _getFontWeight(),
                fontSize: 16,
                color: _getTextColor()),
          ),
          subtitle: Text(
            _getContentLastMessage(),
            style: TextStyle(
                overflow: TextOverflow.ellipsis,
                fontFamily: 'Inter',
                fontWeight: _getFontWeight(),
                fontSize: 14,
                color: _getTextColor()),
          ),
          leading: SizedBox(
            width: 50,
            height: 50,
            child: CircleAvatar(
              // todo set avatar
              backgroundImage: _getImageProvider(),
            ),
          ),
          trailing: Text(
            _getUpdated(),
            style: TextStyle(
                fontFamily: 'Inter',
                fontWeight: _getFontWeight(),
                fontSize: 12,
                color: _getTextColor()),
          ),
        ),
      ),
    );
  }
}
