// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:roomeasy/api/services/conversation/conversation.dart';
import 'package:roomeasy/api/services/upload/upload.dart';
import 'package:roomeasy/app/constant/app_color.dart';
import 'package:roomeasy/app/constant/app_type.dart';
import 'package:roomeasy/app/widget/common/modal_error.dart';
import 'package:roomeasy/form/file/file.dart';
import 'package:roomeasy/form/message/message_create.dart';

class ConversationBottomSend extends StatefulWidget {
  final String conversationId;
  const ConversationBottomSend({
    Key? key,
    required this.conversationId,
  }) : super(key: key);

  @override
  _ConversationBottomSendState createState() => _ConversationBottomSendState();
}

class _ConversationBottomSendState extends State<ConversationBottomSend> {
  TextEditingController msgController = TextEditingController();

  bool isSending = false;

  // handler
  void sendMessageText() async {
    if (msgController.text.trim().isNotEmpty && !isSending) {
      isSending = true;
      final res = await ConversationService().sendMessage(
          widget.conversationId,
          MessageCreateFormModel(
              type: AppType.text, content: msgController.text));

      if (!res.isSuccess()) {
        if (mounted) {
          ModalError().showToast(context, res.code.toString(), res.message);
        }
      }

      msgController.text = "";
      isSending = false;
    }
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
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      color: Colors.white,
      child: Row(
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
    );
  }
}
