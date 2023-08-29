import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:roomeasy/api/services/room/room.dart';
import 'package:roomeasy/app/provider/common/auth.dart';
import 'package:roomeasy/model/room/room.dart';

final roomRecommendProvider =
    FutureProvider.autoDispose<List<RoomModel>>((ref) async {
  final user = ref.watch(authProfileProvider);
  if (user == null) return [];

  final res = await RoomServices().getRecommends();
  if (res.isSuccess() || res.isValidData()) {
    return res.data?.rooms ?? [];
  }

  return [];
});
