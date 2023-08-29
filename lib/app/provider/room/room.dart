// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:roomeasy/model/room/room.dart';

class RoomNotifier extends StateNotifier<List<RoomModel>> {
  RoomNotifier() : super([]);

  void addToList(List<RoomModel> newRooms) {
    state = [...state, ...newRooms];
  }

  void reset(List<RoomModel> newRooms) {
    state = newRooms;
  }
}

final roomProvider =
    StateNotifierProvider<RoomNotifier, List<RoomModel>>((ref) {
  return RoomNotifier();
});
