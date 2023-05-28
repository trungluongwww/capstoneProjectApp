import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:roomeasy/api/services/auth/auth.dart';
import 'package:roomeasy/model/auth/profile.dart';
import 'package:roomeasy/model/response/response.dart';

final authProvider =
    FutureProvider<ResponseModel<AuthProfileModel>>((ref) async {
  return await AuthServices().getMe();
});

class AuthProfileNotifier extends StateNotifier<AuthProfileModel?> {
  AuthProfileNotifier() : super(null);

  Future<void> init() async {
    var res = await AuthServices().getMe();
    if (res.code.toString().startsWith('2')) {
      state = res.data;
    }
  }

  Future<ResponseModel<AuthProfileModel>> refresh() async {
    var res = await AuthServices().getMe();
    if (res.code.toString().startsWith('2')) {
      state = res.data;
    }

    return res;
  }

  void removeCurrentUserState() {
    AuthServices().removeCurrentUserState();
    state = null;
  }
}

final authProfileProvider =
    StateNotifierProvider<AuthProfileNotifier, AuthProfileModel?>((ref) {
  return AuthProfileNotifier();
});
