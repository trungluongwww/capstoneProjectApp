// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:roomeasy/api/services/message/message.dart';
import 'package:roomeasy/api/socket/socket.dart';
import 'package:roomeasy/app/constant/app_color.dart';
import 'package:roomeasy/app/provider/common/auth.dart';
import 'package:roomeasy/app/widget/common/modal_error.dart';
import 'package:roomeasy/app/widget/conversation/conversation_item_message.dart';
import 'package:roomeasy/model/message/message.dart';
import 'package:roomeasy/ultils/strings.dart';

class ConversationListMessage extends ConsumerStatefulWidget {
  final String covnersationId;

  const ConversationListMessage({
    Key? key,
    required this.covnersationId,
  }) : super(key: key);

  @override
  _ConversationListMessageState createState() =>
      _ConversationListMessageState();
}

class _ConversationListMessageState
    extends ConsumerState<ConversationListMessage> {
  // state
  final List<MessageModel> messages = [];
  String pageToken = "";
  bool isLoading = false;

  late String userId = ref.read(authProfileProvider)?.id ?? "";

  // socket
  final _socketManager = SocketManager();

  // stream
  late StreamSubscription<MessageModel> _sub;

  // controller
  late ScrollController _scrollController;

  // event lisner
  void _scrollListener() {
    if (_scrollController.offset <=
            _scrollController.position.minScrollExtent + 20 &&
        !_scrollController.position.outOfRange) {
      loadMoreMessage();
    }
  }

  void onNewMessage() {
    _sub = _socketManager.streamNewMessage.listen((data) {
      if (data.conversationId == widget.covnersationId) {
        setState(() {
          messages.insert(0, data);
        });

        _scrollMax();
      }
    });
  }

  // handler
  void _scrollMax() async {
    Future.delayed(const Duration(milliseconds: 200), () {
      _scrollController.animateTo(_scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 200), curve: Curves.ease);
    });
  }

  // fetch
  void loadMessage() async {
    final res = await MessageService().getAll(widget.covnersationId, pageToken);
    if (!res.isSuccess() && !res.isValidData()) {
      if (mounted) {
        ModalError().showToast(context, res.code.toString(), res.message);
      }
      return;
    }

    setState(() {
      messages.addAll(res.data!.messages);
      pageToken = res.data!.pageToken;
    });

    _scrollMax();
  }

  void loadMoreMessage() async {
    if (pageToken.isEmpty || isLoading) {
      return;
    }

    isLoading = true;

    final res = await MessageService().getAll(widget.covnersationId, pageToken);
    if (!res.isSuccess() && !res.isValidData()) {
      if (mounted) {
        ModalError().showToast(context, res.code.toString(), res.message);
      }
      return;
    }

    setState(() {
      messages.addAll(res.data!.messages);
      pageToken = res.data!.pageToken;
      isLoading = false;
    });
  }

  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    loadMessage();
    super.initState();

    _socketManager.connect().then((_) {
      onNewMessage();
    });
  }

  @override
  void dispose() {
    _socketManager.emitConversationSeen(widget.covnersationId);
    _sub.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      return Container(
        color: AppColor.darkWhiteBackground,
        child: ListView.builder(
          controller: _scrollController,
          itemCount: messages.length,
          itemBuilder: (context, index) {
            if (((index < messages.length - 1 && index > 0) &&
                    (messages[messages.length - index - 1].createdAt?.day !=
                        messages[messages.length - index].createdAt?.day)) ||
                index == 0) {
              return Column(
                children: [
                  Text(
                    UString.getDateWithoutTime(
                        messages[messages.length - index - 1].createdAt!),
                    style: const TextStyle(
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w300,
                        fontSize: 12,
                        color: Colors.black54),
                  ),
                  ConversationItemMessage(
                    message: messages[messages.length - index - 1],
                    maxWidth: constraints.maxWidth * 0.7,
                    userId: userId,
                  )
                ],
              );
            }

            return ConversationItemMessage(
              message: messages[messages.length - index - 1],
              maxWidth: constraints.maxWidth * 0.7,
              userId: userId,
            );
          },
        ),
      );
    });
  }
}
