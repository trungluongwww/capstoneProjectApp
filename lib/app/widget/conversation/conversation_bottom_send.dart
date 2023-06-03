// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:roomeasy/api/services/conversation/conversation.dart';
import 'package:roomeasy/api/services/upload/upload.dart';
import 'package:roomeasy/app/constant/app_color.dart';
import 'package:roomeasy/app/constant/app_type.dart';
import 'package:roomeasy/app/widget/common/cache_image_contain.dart';
import 'package:roomeasy/app/widget/common/modal_error.dart';
import 'package:roomeasy/form/file/file.dart';
import 'package:roomeasy/form/message/message_create.dart';
import 'package:roomeasy/model/room/room.dart';
import 'package:roomeasy/ultils/strings.dart';

class ConversationBottomSend extends StatefulWidget {
  final RoomModel? attachRoom;
  final String conversationId;
  const ConversationBottomSend({
    Key? key,
    required this.attachRoom,
    required this.conversationId,
  }) : super(key: key);

  @override
  _ConversationBottomSendState createState() => _ConversationBottomSendState();
}

class _ConversationBottomSendState extends State<ConversationBottomSend> {
  // state
  RoomModel? attachRoom;

  TextEditingController msgController = TextEditingController();

  bool isSending = false;

  // handler
  void sendMessageText() async {
    if (msgController.text.trim().isNotEmpty && !isSending) {
      isSending = true;
      final res = await ConversationService().sendMessage(
          widget.conversationId,
          MessageCreateFormModel(
              type: attachRoom != null ? AppType.room : AppType.text,
              content: msgController.text.trim(),
              roomId: attachRoom?.id));

      if (!res.isSuccess()) {
        if (mounted) {
          ModalError().showToast(context, res.code.toString(), res.message);
        }
      }

      setState(() {
        attachRoom = null;
      });
      msgController.text = "";
      isSending = false;
    }
  }

  Image getAvatarAttachRoom() {
    if (attachRoom?.getAvatar() != null) {
      return Image.network(
        attachRoom!.getAvatar()!,
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

  void sendMessagePhoto() async {
    if (!isSending) {
      isSending = true;
      var file = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (file != null) {
        final resUpload =
            await UploadService().uploadSinglePhoto(File(file.path));
        if (!resUpload.isSuccess() || !resUpload.isValidData()) {
          if (mounted) {
            ModalError().showToast(
                context, resUpload.code.toString(), resUpload.message);
          }
        } else {
          final res = await ConversationService().sendMessage(
              widget.conversationId,
              MessageCreateFormModel(
                  type: AppType.photo,
                  file: FileFormModel(
                    height: resUpload.data!.height,
                    name: resUpload.data!.name,
                    originName: resUpload.data!.originName,
                    type: resUpload.data!.type,
                    url: resUpload.data!.url,
                    width: resUpload.data!.width,
                  )));

          if (!res.isSuccess()) {
            if (mounted) {
              ModalError().showToast(context, res.code.toString(), res.message);
            }
          }
        }
      }

      isSending = false;
    }
  }

  @override
  void initState() {
    if (widget.attachRoom != null) {
      attachRoom = widget.attachRoom;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          if (attachRoom != null) _getAttachRoom(),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InkWell(
                onTap: sendMessagePhoto,
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.add_a_photo_outlined,
                    color: Colors.black54,
                    size: 20,
                  ),
                ),
              ),
              Expanded(
                child: TextFormField(
                  controller: msgController,
                  validator: (val) {
                    return null;
                  },
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  style: const TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      color: Colors.black87),
                  decoration: const InputDecoration(
                      hintText: "Tin nhắn ...",
                      hintStyle: TextStyle(color: Colors.black54),
                      border: InputBorder.none),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(right: 4),
                width: 40,
                height: 40,
                child: FloatingActionButton(
                  onPressed: sendMessageText,
                  backgroundColor: Colors.blue,
                  elevation: 0,
                  child: const Icon(
                    Icons.send,
                    color: Colors.white,
                    size: 16,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _getAttachRoom() {
    return SizedBox(
      width: double.infinity,
      height: 70,
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 4),
        leading: getAvatarAttachRoom(),
        title: Text(
          attachRoom?.name ?? "",
          overflow: TextOverflow.ellipsis,
          maxLines: 2,
          style: const TextStyle(
              fontFamily: 'Inter',
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.black87),
        ),
        subtitle: Text(
          "${UString.getCurrentcy(attachRoom?.rentPerMonth)} VND",
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
              fontFamily: 'Inter',
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: Colors.black54),
        ),
      ),
    );
  }
}
