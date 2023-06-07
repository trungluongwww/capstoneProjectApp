// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:roomeasy/api/services/conversation/conversation.dart';

import 'package:roomeasy/app/constant/app_color.dart';
import 'package:roomeasy/app/provider/common/auth.dart';
import 'package:roomeasy/app/screen/common/no_network_screen.dart';
import 'package:roomeasy/app/widget/common/modal_error.dart';
import 'package:roomeasy/app/widget/conversation/conversation_bottom_send.dart';
import 'package:roomeasy/app/widget/conversation/conversation_list_message.dart';
import 'package:roomeasy/model/conversation/conversation.dart';
import 'package:roomeasy/model/room/room.dart';

class ConversationDetail extends StatefulWidget {
  final String conversationId;
  final RoomModel? attachRoom;
  const ConversationDetail({
    Key? key,
    required this.conversationId,
    this.attachRoom,
  }) : super(key: key);
  static const routeName = '/conversation-detail';

  @override
  _ConversationDetailState createState() => _ConversationDetailState();
}

class _ConversationDetailState extends State<ConversationDetail> {
  // state
  ConversationModel? conversation;

  // fetch
  void fetchConversation() async {
    final res = await ConversationService().getDetail(widget.conversationId);
    if (!res.isSuccess() || !res.isValidData()) {
      if (mounted) {
        ModalError().showToast(context, res.code.toString(), res.message);
      }
      return;
    }

    setState(() {
      conversation = res.data;
    });

    if (res.code.toString().startsWith('5') && mounted) {
      Navigator.of(context).pushNamedAndRemoveUntil(
          NoNetworkScreen.routerName, (Route route) => false);
    }
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
      body: Column(
        children: [
          Flexible(
            child: ConversationListMessage(
              covnersationId: widget.conversationId,
            ),
          ),
          ConversationBottomSend(
            conversationId: widget.conversationId,
            attachRoom: null,
          )
        ],
      ),
    );
  }
}
