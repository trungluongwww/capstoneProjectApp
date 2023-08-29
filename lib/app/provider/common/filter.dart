import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:roomeasy/api/services/room/room.dart';
import 'package:roomeasy/model/filter/room_filter.dart';
import 'package:roomeasy/model/response/response.dart';

final commonFilterProvider =
    FutureProvider<ResponseModel<RoomFilterModel>>((ref) async {
  return await RoomServices().getFilters();
});
