// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BottomNavbarIndexModel {
  int index;
  BottomNavbarIndexModel({
    required this.index,
  });

  BottomNavbarIndexModel copyWith({
    int? index,
  }) {
    return BottomNavbarIndexModel(
      index: index ?? this.index,
    );
  }
}

class BottomNavbarIndexModelNotifier
    extends StateNotifier<BottomNavbarIndexModel> {
  BottomNavbarIndexModelNotifier() : super(BottomNavbarIndexModel(index: 0));

  void setIndex(int val) {
    state = state.copyWith(index: val);
  }
}

final bottomNavbarIndexProvider = StateNotifierProvider<
    BottomNavbarIndexModelNotifier,
    BottomNavbarIndexModel>((ref) => BottomNavbarIndexModelNotifier());
