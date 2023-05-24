import 'package:flutter/material.dart';
import 'package:roomeasy/api/services/auth/auth.dart';
import 'package:roomeasy/app/widget/account/account_text_field_input.dart';
import 'package:roomeasy/app/widget/common/button_text_primary.dart';
import 'package:roomeasy/app/widget/common/center_content_something_loading.dart';
import 'package:roomeasy/app/widget/common/modal_error.dart';
import 'package:roomeasy/form/user/user_change_password.dart';

class TabChangePassword extends StatefulWidget {
  const TabChangePassword({Key? key}) : super(key: key);

  @override
  State<TabChangePassword> createState() => _TabChangePasswordState();
}

class _TabChangePasswordState extends State<TabChangePassword> {
  late TextEditingController _oldPasswordController;
  late TextEditingController _newPasswordController;
  late TextEditingController _renewPasswordController;
  GlobalKey<FormState> keyForm = GlobalKey<FormState>();

  @override
  void initState() {
    _oldPasswordController = TextEditingController();
    _newPasswordController = TextEditingController();
    _renewPasswordController = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    _oldPasswordController.dispose();
    _newPasswordController.dispose();
    _renewPasswordController.dispose();
    super.dispose();
  }

  // state
  bool isSubmitted = false;

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Form(
        key: keyForm,
        child: Padding(
          padding: const EdgeInsets.only(left: 12, right: 12),
          child: SingleChildScrollView(
            child: Column(
              children: [
                AccountTextFieldInput(
                    controller: _oldPasswordController,
                    validator: (val) {
                      if (val == null || val.trim().isEmpty) {
                        return "Vui lòng nhập ít nhất 6 ký tự";
                      }

                      return null;
                    },
                    hintText: 'Nhập mật khẩu hiện tại',
                    name: 'Mật khẩu cũ'),
                AccountTextFieldInput(
                    controller: _newPasswordController,
                    validator: (val) {
                      if (val == null || val.trim().isEmpty) {
                        return "Vui lòng nhập ít nhất 6 ký tự";
                      }

                      return null;
                    },
                    hintText: 'Nhập mật khẩu mới',
                    name: 'Mật khẩu mới'),
                AccountTextFieldInput(
                    controller: _renewPasswordController,
                    validator: (val) {
                      if (val != _newPasswordController.text) {
                        return "Mật khẩu nhập lại không chính xác";
                      }

                      return null;
                    },
                    hintText: 'Nhập lại mật khẩu mới',
                    name: 'Nhập lại'),
                ButtonTextPrimary(
                    height: 40,
                    onClick: () async {
                      if (!isSubmitted) {
                        if (keyForm.currentState!.validate()) {
                          setState(() {
                            isSubmitted = true;
                          });
                          final res = await AuthServices().changePassword(
                              UserChangePassWordFormModel(
                                  currentPassword: _oldPasswordController.text,
                                  newPassword: _newPasswordController.text));

                          if (res.code.toString().startsWith('2')) {
                            _newPasswordController.text = "";
                            _oldPasswordController.text = "";
                            _renewPasswordController.text = "";
                          }

                          if (mounted) {
                            ModalError().showToast(
                                context, res.code.toString(), res.message!);
                          }

                          setState(() {
                            isSubmitted = false;
                          });
                        }
                      }
                    },
                    title: "Xác nhận")
              ],
            ),
          ),
        ),
      ),
      if (isSubmitted)
        const Positioned.fill(
          child: DecoratedBox(
            decoration: BoxDecoration(color: Colors.black38),
            child: CenterContentSomethingLoading(),
          ),
        )
    ]);
  }
}
