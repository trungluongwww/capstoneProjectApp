// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:roomeasy/app/constant/app_color.dart';
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
      ),
      body: Center(
        child: Text('Trung'),
      ),
    );
  }
}
