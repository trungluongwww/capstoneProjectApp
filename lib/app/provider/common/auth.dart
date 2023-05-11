import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:roomeasy/api/services/auth/auth.dart';
import 'package:roomeasy/model/auth/profile.dart';
import 'package:roomeasy/model/response/response.dart';

final authProvider =
    FutureProvider<ResponseModel<AuthProfileModel>>((ref) async {
  return await AuthServices().getMe();
});
