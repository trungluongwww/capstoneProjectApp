// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:roomeasy/app/constant/app_color.dart';
import 'package:roomeasy/app/constant/app_type.dart';
import 'package:roomeasy/app/widget/common/custom_cache_image.dart';
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
    Image getAvatarRoom() {
      if (message.room?.getAvatar() != null) {
        return Image.network(
          message.room!.getAvatar()!,
          width: 50,
          height: 50,
          fit: BoxFit.cover,
          alignment: Alignment.center,
        );
      }

      return Image.asset(
        'assets/images/default_room.jpg',
        width: 50,
        height: 50,
        fit: BoxFit.cover,
      );
    }

    Widget getContent() {
      Widget? content;
      switch (message.type) {
        case AppType.photo:
          // TODO
          if (message.file?.url != null) {
            content = CustomCacheImage(
              fit: BoxFit.contain,
              url: message.file!.url!,
            );
          } else {
            content = Image.asset('assets/images/default_room.jpg');
          }

          break;
        case AppType.room:
          content = Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                color: Colors.white,
                width: double.infinity,
                height: 70,
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 4),
                  leading: getAvatarRoom(),
                  title: Text(
                    message.room?.name ?? "",
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: const TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87),
                  ),
                  subtitle: Text(
                    "${UString.getCurrentcy(message.room?.rentPerMonth)} VND",
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Colors.black54),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  message.content ?? "",
                  style: TextStyle(
                      fontSize: 14,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                      color: userId == message.authorId
                          ? Colors.white
                          : AppColor.textBlue),
                ),
              )
            ],
          );
          break;
        default:
          content = Text(
            message.content ?? "",
            style: TextStyle(
                fontSize: 14,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w400,
                color: userId == message.authorId
                    ? Colors.white
                    : AppColor.textBlue),
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
              color: (userId != message.authorId
                  ? Colors.white
                  : AppColor.lightPrimary),
            ),
            padding: const EdgeInsets.all(8),
            child: getContent()),
      ),
    );
  }
}
