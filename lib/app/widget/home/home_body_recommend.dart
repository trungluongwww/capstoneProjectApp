import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:roomeasy/app/constant/app_color.dart';
import 'package:roomeasy/app/provider/room/room_recommend.dart';
import 'package:roomeasy/app/screen/room/room_detail.dart';
import 'package:roomeasy/app/widget/common/center_content_something_error.dart';
import 'package:roomeasy/app/widget/common/center_content_something_loading.dart';

class HomeBodyRecommend extends ConsumerStatefulWidget {
  const HomeBodyRecommend({Key? key}) : super(key: key);

  @override
  ConsumerState createState() => _HomeBodyRecommendState();
}

class _HomeBodyRecommendState extends ConsumerState<HomeBodyRecommend> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final rooms = ref.watch(roomRecommendProvider);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        rooms.when(
          data: (data) {
            if (data.isEmpty) return const SizedBox();
            return Container(
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    color: AppColor.darkWhiteBackground,
                    padding: const EdgeInsets.all(8),
                    child: const Text(
                      'Đề xuất gần bạn',
                      style: TextStyle(
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          color: Colors.black),
                    ),
                  ),
                  ...data
                      .map(
                        (e) => InkWell(
                          splashColor: Colors.grey,
                          onTap: () {
                            if (e.id != null) {
                              Navigator.of(context).pushNamed(
                                  RoomDetailScreen.routeName,
                                  arguments: {'id': e.id});
                            }
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(vertical: 4),
                            child: ListTile(
                              contentPadding: EdgeInsets.zero,
                              leading: SizedBox(
                                width: 100,
                                height: 100,
                                child: e.getAvatar() != null
                                    ? Image.network(
                                        e.getAvatar()!,
                                        fit: BoxFit.cover,
                                        height: 100,
                                      )
                                    : Image.asset(
                                        'assets/images/default_room.jpg',
                                        fit: BoxFit.cover,
                                        height: 100,
                                      ),
                              ),
                              title: Text(
                                e.name ?? "",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14,
                                    color: Colors.black),
                              ),
                              subtitle: Text(
                                e.getFullNameLocation() ?? "",
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w300,
                                    fontSize: 12,
                                    color: Colors.black),
                              ),
                            ),
                          ),
                        ),
                      )
                      .toList()
                ],
              ),
            );
          },
          error: (error, stackTrace) => const CenterContentSomethingError(),
          loading: () => const CenterContentSomethingLoading(),
        ),
        const Padding(
          padding: EdgeInsets.all(8),
          child: Text(
            'Danh sách tất cả',
            style: TextStyle(
                fontFamily: 'Inter',
                fontWeight: FontWeight.w500,
                fontSize: 16,
                color: Colors.black),
          ),
        ),
      ],
    );
  }
}
