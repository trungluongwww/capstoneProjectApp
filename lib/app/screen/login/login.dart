import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:roomeasy/app/widget/login/login_app_bar.dart';

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

  void _onSubmitForm() {
    formKey.currentState!.validate();
  }

  // key
  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: const LoginAppBar(),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return Form(
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
                          validator: (val) {
                            if (val == null || val.isEmpty) {
                              return "Vui lòng điền thông tin email";
                            }

                            if (val.length < 6) {
                              return "Mật khẩu chứa ít nhất 6 ký tự";
                            }

                            return null;
                          },
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(fontSize: 18),
                          decoration: const InputDecoration(
                              errorStyle: TextStyle(
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
                        child: ElevatedButton(
                            onPressed: _onSubmitForm,
                            child: const Text('Đăng nhập')),
                      ),
                      const Positioned(
                          bottom: 12,
                          right: 12,
                          child: Icon(
                            Icons.keyboard_arrow_right,
                            color: Colors.white,
                          ))
                    ],
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
