import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:roomeasy/api/services/room/room.dart';
import 'package:roomeasy/model/response/response.dart';
import 'package:roomeasy/model/room/room.dart';

final roomDetailProvider = FutureProvider.autoDispose
    .family<ResponseModel<RoomModel>, String>((ref, id) async {
  return await RoomServices().getDetailRoom(id: id);
});
