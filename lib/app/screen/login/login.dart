import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:roomeasy/api/services/auth/auth.dart';
import 'package:roomeasy/app/provider/common/auth.dart';
import 'package:roomeasy/app/screen/register/register.dart';
import 'package:roomeasy/app/widget/common/modal_error.dart';
import 'package:roomeasy/app/widget/common/position_center_loading.dart';
import 'package:roomeasy/app/widget/login/login_app_bar.dart';
import 'package:roomeasy/form/login.dart';

class LoginScreen extends StatefulWidget {
  static const String routerName = '/login';
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late FocusNode _focusNodeEmail;
  bool _isFocusedEmail = false;

  late FocusNode _focusNodePassword;
  bool _isFocusedPassword = false;

  // state
  bool isLoading = false;
  bool passwordVisible = true;

  // key
  GlobalKey<FormState> formKey = GlobalKey();

  // controller
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _focusNodeEmail = FocusNode();
    _focusNodeEmail.addListener(_handleFocusEmailChange);
    _focusNodePassword = FocusNode();
    _focusNodePassword.addListener(_handleFocusPasswordChange);
  }

  @override
  void dispose() {
    _focusNodeEmail.removeListener(_handleFocusEmailChange);
    _focusNodeEmail.dispose();

    _focusNodePassword.removeListener(_handleFocusPasswordChange);
    _focusNodePassword.dispose();

    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleFocusEmailChange() {
    setState(() {
      _isFocusedEmail = _focusNodeEmail.hasFocus;
    });
  }

  void _handleFocusPasswordChange() {
    setState(() {
      _isFocusedPassword = _focusNodePassword.hasFocus;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: const LoginAppBar(),
      body: SafeArea(
        top: true,
        bottom: true,
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            return Stack(children: [
              Form(
                key: formKey,
                child: Container(
                  padding: const EdgeInsets.only(left: 16, right: 16, top: 32),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Text(
                          'Đăng nhập',
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(color: Colors.black),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 12, bottom: 12),
                        width: double.infinity,
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                              width: 0.5,
                              color: _isFocusedEmail
                                  ? Colors.lightBlue
                                  : Colors.black54,
                            ),
                            boxShadow: _isFocusedEmail
                                ? [BoxShadow(color: Colors.blue, blurRadius: 2)]
                                : null,
                            borderRadius: BorderRadius.circular(8)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Email',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(color: Colors.black87),
                            ),
                            TextFormField(
                              controller: _emailController,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge!
                                  .copyWith(fontSize: 18),
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
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 12, bottom: 12),
                        width: double.infinity,
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                              width: 0.5,
                              color: _isFocusedPassword
                                  ? Colors.lightBlue
                                  : Colors.black54,
                            ),
                            boxShadow: _isFocusedPassword
                                ? [
                                    const BoxShadow(
                                        color: Colors.blue, blurRadius: 2)
                                  ]
                                : null,
                            borderRadius: BorderRadius.circular(8)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Mật khẩu',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(color: Colors.black87),
                            ),
                            TextFormField(
                              controller: _passwordController,
                              validator: (val) {
                                if (val == null || val.isEmpty) {
                                  return "Vui lòng nhập mật khẩu";
                                }

                                if (val.length < 6) {
                                  return "Mật khẩu chứa ít nhất 6 ký tự";
                                }

                                return null;
                              },
                              obscureText: passwordVisible,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge!
                                  .copyWith(fontSize: 18),
                              decoration: InputDecoration(
                                  suffixIcon: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          passwordVisible = !passwordVisible;
                                        });
                                      },
                                      icon: passwordVisible
                                          ? const Icon(Icons.visibility)
                                          : const Icon(Icons.visibility_off)),
                                  errorStyle: const TextStyle(
                                      color: Colors.red,
                                      fontFamily: 'Inter',
                                      overflow: TextOverflow.ellipsis,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12),
                                  hintText: 'Nhập mật khẩu',
                                  border: InputBorder.none),
                              focusNode: _focusNodePassword,
                            ),
                          ],
                        ),
                      ),
                      Stack(
                        children: [
                          Container(
                            width: double.infinity,
                            margin: const EdgeInsets.only(top: 32),
                            height: 48,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8)),
                            clipBehavior: Clip.hardEdge,
                            child: Consumer(builder: (context, ref, child) {
                              return ElevatedButton(
                                  onPressed: () async {
                                    if (formKey.currentState!.validate()) {
                                      setState(() {
                                        isLoading = true;
                                      });
                                      LoginFormModel data = LoginFormModel(
                                          email: _emailController.value.text,
                                          password:
                                              _passwordController.value.text);

                                      var res = await AuthServices()
                                          .login(formData: data);
                                      if (mounted && !res.isSuccess()) {
                                        setState(() {
                                          isLoading = false;
                                        });
                                        ModalError().showToast(context,
                                            res.code!.toString(), res.message!);
                                        return;
                                      }
                                      var user = await ref
                                          .read(authProfileProvider.notifier)
                                          .refresh();

                                      setState(() {
                                        isLoading = false;
                                      });

                                      if (mounted) {
                                        ModalError().showToast(context,
                                            res.code!.toString(), res.message!);
                                        if (user.isSuccess()) {
                                          Navigator.of(context).pop();
                                        }
                                        return;
                                      }
                                    }
                                  },
                                  child: const Text('Đăng nhập'));
                            }),
                          ),
                          const Positioned(
                              bottom: 12,
                              right: 12,
                              child: Icon(
                                Icons.keyboard_arrow_right,
                                color: Colors.white,
                              ))
                        ],
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.of(context)
                              .pushReplacementNamed(RegisterScreen.routerName);
                        },
                        child: const Padding(
                          padding: EdgeInsets.only(top: 12),
                          child: Text(
                            'Đăng ký tài khoản',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.blue,
                                fontFamily: 'Inter',
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                decoration: TextDecoration.underline),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              if (isLoading) const PositionCenterLoading()
            ]);
          },
        ),
      ),
    );
  }
}
