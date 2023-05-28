import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:roomeasy/app/provider/common/filter.dart';
import 'package:roomeasy/app/widget/room_create/room_create_radio_input.dart';
import 'package:roomeasy/model/filter/room_filter.dart';
import 'package:roomeasy/model/response/response.dart';

class RoomCreateGroupType extends ConsumerStatefulWidget {
  const RoomCreateGroupType({Key? key}) : super(key: key);
  @override
  ConsumerState<RoomCreateGroupType> createState() =>
      RoomCreateGroupTypeState();
}

class RoomCreateGroupTypeState extends ConsumerState<RoomCreateGroupType> {
  String finalValue = '';

  // state
  late String groupValue = '';

  @override
  void initState() {
    super.initState();
  }

  // event
  void onChangedType(val) {
    setState(() {
      groupValue = val as String;
      finalValue = groupValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    AsyncValue<ResponseModel<RoomFilterModel>> config =
        ref.watch(commonFilterProvider);
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'LOẠI PHÒNG',
            style: TextStyle(
                color: Colors.black54,
                fontFamily: 'Inter',
                fontSize: 16,
                fontWeight: FontWeight.w400),
          ),
          ...config.when(
            data: (res) {
              if (res.code.toString().startsWith('2')) {
                return res.data!.types
                    .map((e) => RoomCreateRadioInput(
                        title: e.value!,
                        value: e.key!,
                        groupValue: groupValue,
                        onChange: onChangedType))
                    .toList();
              }
              return [const CircularProgressIndicator()];
            },
            error: (error, stackTrace) {
              return [const CircularProgressIndicator()];
            },
            loading: () => [const CircularProgressIndicator()],
          )
        ],
      ),
    );
  }
}
