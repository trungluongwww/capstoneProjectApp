import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:roomeasy/api/services/auth/auth.dart';
import 'package:roomeasy/app/constant/app_color.dart';
import 'package:roomeasy/app/screen/reset_password/reset_password.dart';
import 'package:roomeasy/app/widget/common/modal_error.dart';
import 'package:roomeasy/app/widget/common/position_center_loading.dart';
import 'package:roomeasy/app/widget/forgot_password/forgot_app_bar.dart';
import 'package:roomeasy/form/user/user_forgot_password.dart';

class ForgotPassword extends StatefulWidget {
  static const String routerName = '/forgot-password';
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  GlobalKey<FormState> formKey = GlobalKey();

  late FocusNode _focusNodeEmail;
  bool _isFocusedEmail = false;
  final _emailController = TextEditingController();

  bool isLoading = false;

  void _handleFocusEmailChange() {
    setState(() {
      _isFocusedEmail = _focusNodeEmail.hasFocus;
    });
  }

  @override
  void initState() {
    super.initState();
    _focusNodeEmail = FocusNode();
    _focusNodeEmail.addListener(_handleFocusEmailChange);
  }

  @override
  void dispose() {
    _focusNodeEmail.removeListener(_handleFocusEmailChange);
    _focusNodeEmail.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: const ForgotAppBar(),
      body: SafeArea(
          top: true,
          bottom: true,
          child: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
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
                              color: _isFocusedEmail
                                  ? AppColor.lightPrimary
                                  : AppColor.textBlue,
                            ),
                            boxShadow: _isFocusedEmail
                                ? [
                                    const BoxShadow(
                                        color: AppColor.primary, blurRadius: 2)
                                  ]
                                : null,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Email',
                                  style: TextStyle(
                                      fontFamily: 'Inter',
                                      fontSize: 16,
                                      color: AppColor.textBlue,
                                      fontWeight: FontWeight.w400)),
                              TextFormField(
                                controller: _emailController,
                                style: const TextStyle(
                                    fontFamily: 'Inter',
                                    fontSize: 18,
                                    color: Colors.black87,
                                    fontWeight: FontWeight.w600),
                                validator: (val) {
                                  if (val == null || val.isEmpty) {
                                    return "Vui lòng điền thông tin email";
                                  }

                                  if (!EmailValidator.validate(val)) {
                                    return "Email không hợp lệ";
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
                                    hintText: 'Nhập email',
                                    border: InputBorder.none),
                                focusNode: _focusNodeEmail,
                              ),
                              ElevatedButton(
                                  style: const ButtonStyle(
                                    backgroundColor: MaterialStatePropertyAll(
                                        AppColor.primary),
                                  ),
                                  onPressed: () async {
                                    if (formKey.currentState!.validate()) {
                                      FocusScopeNode currentNode =
                                          FocusScope.of(context);
                                      if (!currentNode.hasPrimaryFocus) {
                                        currentNode.unfocus();
                                      }

                                      setState(() {
                                        isLoading = true;
                                      });

                                      UserForgotPasswordFormModel formData =
                                          UserForgotPasswordFormModel(
                                              email:
                                                  _emailController.value.text);
                                      var res = await AuthServices()
                                          .forgotPassword(formData);

                                      setState(() {
                                        isLoading = false;
                                      });

                                      if (mounted) {
                                        if (!res.isSuccess()) {
                                          ModalError().showToast(
                                              context,
                                              res.code!.toString(),
                                              res.message!);
                                          return;
                                        } else {
                                          ModalError().showToast(
                                              context,
                                              res.code!.toString(),
                                              res.data?.message ?? "");

                                          Navigator.of(context)
                                              .pushReplacementNamed(
                                                  ResetPassword.routerName,
                                                  arguments: {
                                                'email':
                                                    _emailController.value.text
                                              });
                                        }
                                      }
                                    }
                                  },
                                  child: const Text(
                                    'Yêu cầu đổi mật khẩu',
                                    style: TextStyle(
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white,
                                        fontSize: 14),
                                  ))
                            ],
                          ),
                        ),
                      ),
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
