// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:roomeasy/api/services/conversation/conversation.dart';
import 'package:roomeasy/api/socket/socket.dart';

import 'package:roomeasy/app/constant/app_color.dart';
import 'package:roomeasy/app/provider/common/auth.dart';
import 'package:roomeasy/app/widget/common/center_content_something_loading.dart';
import 'package:roomeasy/app/widget/common/modal_error.dart';
import 'package:roomeasy/app/widget/conversation/conversation_bottom_send.dart';
import 'package:roomeasy/app/widget/conversation/conversation_list_message.dart';
import 'package:roomeasy/model/conversation/conversation.dart';
import 'package:roomeasy/model/room/room.dart';

class ConversationDetailByUser extends StatefulWidget {
  final RoomModel? attachRoom;
  final String targetId;
  const ConversationDetailByUser({
    Key? key,
    required this.targetId,
    this.attachRoom,
  }) : super(key: key);
  static const routeName = '/conversation-detail-by-user';

  @override
  _ConversationDetailByUserState createState() =>
      _ConversationDetailByUserState();
}

class _ConversationDetailByUserState extends State<ConversationDetailByUser> {
  // state
  ConversationModel? conversation;

  // fetch
  void fetchConversation() async {
    final res = await ConversationService().getDetailByUserId(widget.targetId);
    if (!res.isSuccess() || !res.isValidData()) {
      if (mounted) {
        ModalError().showToast(context, res.code.toString(), res.message);
        Navigator.pop(context);
      }
      return;
    }

    setState(() {
      conversation = res.data;
    });
  }

  // helper
  String _getNameRoom(String? userId) {
    if (userId == conversation?.owner?.id) {
      return conversation?.participant?.name ?? "User not found";
    }

    return conversation?.owner?.name ?? "User not found";
  }

  @override
  void initState() {
    fetchConversation();
    super.initState();
  }

  @override
  void dispose() {
    SocketManager().disconnect();
    super.dispose();
  }

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
          title: Consumer(builder: (context, ref, child) {
            final userId = ref.watch(authProfileProvider)?.id;
            return Text(
              _getNameRoom(userId),
              style: const TextStyle(
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                  color: Colors.black87),
            );
          }),
        ),
        body: conversation != null
            ? Column(
                children: [
                  Flexible(
                    child: ConversationListMessage(
                      covnersationId: conversation!.id!,
                    ),
                  ),
                  ConversationBottomSend(
                    conversationId: conversation!.id!,
                    attachRoom: widget.attachRoom,
                  )
                ],
              )
            : Container(
                color: Colors.white,
                child: const CenterContentSomethingLoading()));
  }
}
