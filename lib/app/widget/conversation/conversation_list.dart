import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:roomeasy/api/services/conversation/conversation.dart';
import 'package:roomeasy/api/socket/socket.dart';
import 'package:roomeasy/app/constant/app_color.dart';
import 'package:roomeasy/app/provider/common/auth.dart';
import 'package:roomeasy/app/screen/common/no_network_screen.dart';
import 'package:roomeasy/app/widget/common/center_content_something_loading.dart';
import 'package:roomeasy/app/widget/conversation/conversation_list_item.dart';
import 'package:roomeasy/model/conversation/conversation.dart';

class ConversationList extends ConsumerStatefulWidget {
  const ConversationList({Key? key}) : super(key: key);

  @override
  _ConversationListState createState() => _ConversationListState();
}

class _ConversationListState extends ConsumerState<ConversationList> {
  // socket
  final _socketManager = SocketManager();

  // stream
  late StreamSubscription _sub;

  // state
  bool isGlobalLoading = false;

  List<ConversationModel> convs = [];
  String pageToken = "";

  // controller
  late ScrollController _scrollController;

  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);

    refreshConversation();
    super.initState();

    _socketManager.connect().then((_) => onNewMessage());
  }

  void onNewMessage() {
    _sub = _socketManager.streamNewMessage.listen((data) {
      var conv = convs
          .firstWhere(
            (element) => element.id == data.conversationId,
            orElse: () => ConversationModel(),
          )
          .copyWith(lastMessage: data);

      conv = conv.copyWith(
          unread: conv.unread ?? 0 + 1, lastSenderId: data.authorId);

      if (conv.id != null) {
        setState(() {
          convs.removeWhere((element) => element.id == conv.id);
          convs.insert(0, conv);
        });
      }
    });
  }

  Future<void> refreshConversation() async {
    if (isGlobalLoading) {
      return;
    }

    setState(() {
      isGlobalLoading = true;
      pageToken = "";
    });

    final res = await ConversationService().getAll(pageToken);

    if (res.data != null) {
      setState(() {
        convs = res.data!.conversations!;
        pageToken = res.data!.pageToken ?? "";
      });
    }

    setState(() {
      isGlobalLoading = false;
    });

    if (res.code.toString().startsWith('5') && mounted) {
      Navigator.of(context).pushNamedAndRemoveUntil(
          NoNetworkScreen.routerName, (Route route) => false);
    }
  }

  Future<void> loadMoreConversation() async {
    if (isGlobalLoading || pageToken.isEmpty) {
      return;
    }

    final res = await ConversationService().getAll(pageToken);

    if (res.data?.conversations != null) {
      setState(() {
        convs.addAll(res.data!.conversations!);
      });
    }

    pageToken = res.data?.pageToken ?? "";
  }

  // handler
  void onSeenConversation(String id) {
    var index = convs.indexWhere((element) => element.id == id);
    setState(() {
      convs[index] =
          convs.firstWhere((element) => element.id == id).copyWith(unread: 0);
    });
  }

  // event
  // event lisner
  void _scrollListener() {
    if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      loadMoreConversation();
    }
  }

  @override
  Widget build(BuildContext context) {
    final userId = ref.watch(authProfileProvider)?.id;
    return RefreshIndicator(
      onRefresh: refreshConversation,
      child: Material(
        color: AppColor.darkWhiteBackground,
        child: isGlobalLoading
            ? const CenterContentSomethingLoading()
            : ListView.builder(
                controller: _scrollController,
                itemCount: convs.length,
                itemBuilder: (context, index) {
                  return ConversationListItem(
                      seenConversation: onSeenConversation,
                      conv: convs[index],
                      userId: userId ?? "");
                },
              ),
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    _socketManager.disconnect();
    _sub.pause();
    super.dispose();
  }
}
