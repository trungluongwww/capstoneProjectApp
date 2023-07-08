import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:roomeasy/api/services/auth/auth.dart';
import 'package:roomeasy/app/constant/app_color.dart';
import 'package:roomeasy/app/provider/common/auth.dart';
import 'package:roomeasy/app/widget/common/modal_error.dart';
import 'package:roomeasy/app/widget/common/position_center_loading.dart';
import 'package:roomeasy/app/widget/reset_password/reset_app_bar.dart';
import 'package:roomeasy/form/user/user_forgot_password.dart';
import 'package:roomeasy/form/user/user_reset_password.dart';

class ResetPassword extends StatefulWidget {
  static const String routerName = '/reset-password';
  final String email;
  const ResetPassword({
    Key? key,
    required this.email,
  }) : super(key: key);

  @override
  State createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  GlobalKey<FormState> formKey = GlobalKey();

  late FocusNode _focusNodePassword;
  bool _isFocusedPassword = false;
  final _passwordController = TextEditingController();

  bool isLoading = false;

  void _handleFocusPasswordChange() {
    setState(() {
      _isFocusedPassword = _focusNodePassword.hasFocus;
    });
  }

  @override
  void initState() {
    super.initState();
    _focusNodePassword = FocusNode();
    _focusNodePassword.addListener(_handleFocusPasswordChange);
  }

  @override
  void dispose() {
    _focusNodePassword.removeListener(_handleFocusPasswordChange);
    _focusNodePassword.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: const ResetAppBar(),
      body: SafeArea(
          top: true,
          bottom: true,
          child: LayoutBuilder(
              builder: (BuildContext context1, BoxConstraints constraints) {
            return Stack(
              children: [
                Form(
                  key: formKey,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          margin: const EdgeInsets.symmetric(
                              vertical: 12, horizontal: 20),
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(
                              vertical: 12, horizontal: 24),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                              width: 0.5,
                              color: _isFocusedPassword
                                  ? AppColor.lightPrimary
                                  : AppColor.textBlue,
                            ),
                            boxShadow: _isFocusedPassword
                                ? [
                                    const BoxShadow(
                                        color: AppColor.primary, blurRadius: 2)
                                  ]
                                : null,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Mã xác thực',
                                  style: TextStyle(
                                      fontFamily: 'Inter',
                                      fontSize: 16,
                                      color: AppColor.textBlue,
                                      fontWeight: FontWeight.w400)),
                              TextFormField(
                                controller: _passwordController,
                                style: const TextStyle(
                                    fontFamily: 'Inter',
                                    fontSize: 18,
                                    color: Colors.black87,
                                    fontWeight: FontWeight.w600),
                                validator: (val) {
                                  if (val == null || val.isEmpty) {
                                    return "Vui lòng điền thông tin mã xác thực";
                                  }

                                  return null;
                                },
                                decoration: const InputDecoration(
                                    errorStyle: TextStyle(
                                        color: Colors.red,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w400,
                                        fontSize: 12,
                                        overflow: TextOverflow.ellipsis),
                                    hintText: 'Nhập mã xác nhận',
                                    border: InputBorder.none),
                                focusNode: _focusNodePassword,
                              ),
                              Consumer(
                                builder: (context2, ref, child) =>
                                    ElevatedButton(
                                        style: const ButtonStyle(
                                          backgroundColor:
                                              MaterialStatePropertyAll(
                                                  AppColor.primary),
                                        ),
                                        onPressed: () async {
                                          if (formKey.currentState!
                                              .validate()) {
                                            FocusScopeNode currentNode =
                                                FocusScope.of(context);
                                            if (!currentNode.hasPrimaryFocus) {
                                              currentNode.unfocus();
                                            }

                                            setState(() {
                                              isLoading = true;
                                            });

                                            UserResetPasswordFormModel
                                                formData =
                                                UserResetPasswordFormModel(
                                                    email: widget.email,
                                                    password:
                                                        _passwordController
                                                            .value.text);
                                            var res = await AuthServices()
                                                .resetPassword(formData);

                                            setState(() {
                                              isLoading = false;
                                            });

                                            if (mounted) {
                                              if (!res.isSuccess()) {
                                                ModalError().showToast(
                                                    context,
                                                    res.code!.toString(),
                                                    res.message!);
                                              } else {
                                                ModalError().showToast(
                                                    context,
                                                    res.code!.toString(),
                                                    res.message ?? "");

                                                await ref
                                                    .read(authProfileProvider
                                                        .notifier)
                                                    .refresh();

                                                if (context.mounted) {
                                                  Navigator.of(context).pop();
                                                }
                                              }
                                            }
                                          }
                                        },
                                        child: const Text(
                                          'Xác nhận',
                                          style: TextStyle(
                                              fontFamily: 'Inter',
                                              fontWeight: FontWeight.w500,
                                              color: Colors.white,
                                              fontSize: 14),
                                        )),
                              )
                            ],
                          ),
                        ),
                      ),
                      const Text('Hãy kiểm tra email để xác nhận mật khẩu mới',
                          style: TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 14,
                              color: Colors.red,
                              fontWeight: FontWeight.w300)),
                    ],
                  ),
                ),
                if (isLoading) const PositionCenterLoading()
              ],
            );
          })),
    );
  }
}
