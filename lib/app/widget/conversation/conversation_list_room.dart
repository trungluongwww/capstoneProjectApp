import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:roomeasy/api/services/conversation/conversation.dart';
import 'package:roomeasy/app/constant/app_color.dart';
import 'package:roomeasy/app/provider/common/auth.dart';
import 'package:roomeasy/app/widget/common/center_content_something_loading.dart';
import 'package:roomeasy/app/widget/conversation/conversation_list_item.dart';
import 'package:roomeasy/model/conversation/conversation.dart';

class ConversationListRoom extends ConsumerStatefulWidget {
  const ConversationListRoom({Key? key}) : super(key: key);

  @override
  _ConversationListRoomState createState() => _ConversationListRoomState();
}

class _ConversationListRoomState extends ConsumerState<ConversationListRoom> {
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
        color: AppColor.appDarkWhiteColor,
        child: isGlobalLoading
            ? const CenterContentSomethingLoading()
            : ListView.builder(
                controller: _scrollController,
                itemCount: convs.length,
                itemBuilder: (context, index) {
                  return ConversationListItem(
                      conv: convs[index], userId: userId ?? "");
                },
              ),
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }
}
