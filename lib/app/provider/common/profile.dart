import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:roomeasy/api/services/auth/auth.dart';
import 'package:roomeasy/model/auth/profile.dart';
import 'package:roomeasy/model/response/response.dart';

final userProfileProvider = FutureProvider.autoDispose
    .family<ResponseModel<AuthProfileModel>, String>((ref, userId) async {
  return await AuthServices().getUserProfile(userId: userId);
});
