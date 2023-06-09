import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:roomeasy/app/constant/app_color.dart';
import 'package:roomeasy/app/provider/common/filter.dart';
import 'package:roomeasy/app/provider/home/home_filter_data.dart';
import 'package:roomeasy/model/filter/room_filter.dart';
import 'package:roomeasy/model/response/response.dart';

class HomeFilterCategory extends ConsumerStatefulWidget {
  const HomeFilterCategory({Key? key}) : super(key: key);

  @override
  _HomeFilterCategoryState createState() => _HomeFilterCategoryState();
}

class _HomeFilterCategoryState extends ConsumerState<HomeFilterCategory> {
  @override
  Widget build(BuildContext context) {
    // provider
    AsyncValue<ResponseModel<RoomFilterModel>> filterProvider =
        ref.watch(commonFilterProvider);

    String? selectedRoomType = ref.watch(homeFilterProvider).roomType;

    return Container(
      width: double.infinity,
      color: AppColor.darkWhiteBackground,
      constraints: const BoxConstraints(
        minHeight: 0,
        maxHeight: double.infinity,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 10, top: 5, bottom: 5),
            child: Text("Loại nhà thuê",
                style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 16,
                    color: Colors.black87,
                    fontWeight: FontWeight.w600)),
          ),
          Container(
            color: AppColor.white,
            width: double.infinity,
            height: 56,
            child: filterProvider.when(
              data: (res) {
                if (res.code.toString().startsWith('2') && res.data != null) {
                  return SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: res.data!.types.map<Widget>((e) {
                        return InkWell(
                          onTap: () {
                            ref
                                .read(homeFilterProvider.notifier)
                                .setRoomType(e.key);
                          },
                          child: Container(
                            margin: const EdgeInsets.only(left: 8, right: 8),
                            padding: const EdgeInsets.only(
                                top: 8, bottom: 8, left: 8, right: 8),
                            decoration: BoxDecoration(
                              border: selectedRoomType == e.key
                                  ? null
                                  : Border.all(width: 1, color: Colors.black54),
                              borderRadius: BorderRadius.circular(10),
                              color: selectedRoomType == e.key
                                  ? AppColor.lightPrimary
                                  : Colors.white70,
                            ),
                            child: Text(
                              e.value!,
                              style: TextStyle(
                                  fontSize: 14,
                                  color: selectedRoomType == e.key
                                      ? Colors.white
                                      : Colors.black87),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  );
                }
                return null;
              },
              error: (error, stackTrace) => null,
              loading: () => null,
            ),
          )
        ],
      ),
    );
  }
}
