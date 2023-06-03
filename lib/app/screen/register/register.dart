import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:roomeasy/api/services/auth/auth.dart';
import 'package:roomeasy/app/constant/app_color.dart';
import 'package:roomeasy/app/provider/common/auth.dart';
import 'package:roomeasy/app/screen/location/location.dart';
import 'package:roomeasy/app/widget/common/modal_error.dart';
import 'package:roomeasy/app/widget/register/register_app_bar.dart';
import 'package:roomeasy/app/widget/register/register_input_default.dart';
import 'package:roomeasy/app/widget/register/register_location.dart';
import 'package:roomeasy/form/location/location.dart';
import 'package:roomeasy/form/register/register.dart';

class RegisterScreen extends ConsumerStatefulWidget {
  static const routerName = '/register';
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _rePasswordController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  LocationFormModel locationData = LocationFormModel();

  // key
  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    void _onSelectedLoation() async {
      var rs = await Navigator.of(context)
          .pushNamed(SelectLocationScreen.routerName, arguments: locationData);

      setState(() {
        locationData = LocationFormModel.fromData(rs);
      });
    }

    void onSubmit() async {
      if (!formKey.currentState!.validate()) return;

      String message = "";
      String code = '200';

      // validate location
      if (locationData.provinceId == null ||
          locationData.districtId == null ||
          locationData.wardId == null) {
        message = "Vui lòng điền đầy đủ thông tin địa chỉ";
        code = '400';
      }

      if (code.startsWith('2')) {
        RegisterFormModel data = RegisterFormModel(
            email: _emailController.value.text,
            password: _passwordController.value.text,
            phone: _phoneController.value.text,
            name: _nameController.value.text,
            provinceId: locationData.provinceId!,
            districtId: locationData.districtId!,
            wardId: locationData.wardId!,
            address: _addressController.value.text);

        var res = await AuthServices().register(formData: data);
        message = res.message ?? "";
        code = res.code.toString();
      }

      if (code.startsWith('2')) {
        var res = await ref.read(authProfileProvider.notifier).refresh();
        message = res.message ?? "";
        code = res.code.toString();
      }

      if (mounted) {
        ModalError().showToast(context, code, message);

        if (code.startsWith('2')) {
          Navigator.pop(context);
        }
      }
    }

    return Scaffold(
      appBar: RegisterAppbar(onSubmit: onSubmit),
      backgroundColor: AppColor.appDarkWhiteColor,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
          child: SingleChildScrollView(
        child: Container(
          color: AppColor.appDarkWhiteColor,
          padding: const EdgeInsets.only(top: 12, left: 12, right: 12),
          width: double.infinity,
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RegisterInputDefault(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Vui lòng điền thông tin email";
                    }

                    if (!EmailValidator.validate(value)) {
                      return "Email không hợp lệ";
                    }

                    return null;
                  },
                  hintText: 'Nhập tên email',
                  labelText: 'Email',
                ),
                RegisterInputDefault(
                  controller: _phoneController,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.trim().length != 10) {
                      return "Số điện thoại bao gồm 10 chữ số";
                    }
                    return null;
                  },
                  hintText: 'Nhập số điện thoại',
                  labelText: 'Số điện thoại',
                ),
                RegisterInputDefault(
                  controller: _nameController,
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    if (value == null || value.trim().length < 8) {
                      return "Ít nhất 8 ký tự";
                    }
                    return null;
                  },
                  hintText: 'Nhập tên ngươi dùng',
                  labelText: 'Tên người dùng',
                ),
                RegisterInputDefault(
                  keyboardType: TextInputType.text,
                  controller: _passwordController,
                  validator: (value) {
                    if (value == null || value.trim().length < 8) {
                      return "Ít nhất 8 ký tự";
                    }
                    return null;
                  },
                  hintText: 'khẩu mật khẩu',
                  labelText: 'Mật khẩu',
                ),
                RegisterInputDefault(
                  keyboardType: TextInputType.text,
                  controller: _rePasswordController,
                  validator: (value) {
                    if (value == null || value.trim().length < 8) {
                      return "Ít nhất 8 ký tự";
                    }

                    if (value != _passwordController.value.text) {
                      return " Mật khẩu nhập lại không chính xác";
                    }
                    return null;
                  },
                  hintText: 'Nhập lại mật khẩu',
                  labelText: 'Xác nhân mật khẩu',
                ),
                RegisterLocation(
                    onSelected: _onSelectedLoation, location: locationData),
                RegisterInputDefault(
                  keyboardType: TextInputType.text,
                  controller: _addressController,
                  validator: (value) {
                    if (value == null || value.trim().length < 8) {
                      return "Ít nhất 8 ký tự";
                    }

                    return null;
                  },
                  hintText: 'Nhập tên đường, số nhà, số kiệt, hẻm ... ',
                  labelText: 'Địa chỉ chi tiết',
                ),
              ],
            ),
          ),
        ),
      )),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _phoneController.dispose();
    _nameController.dispose();
    _passwordController.dispose();
    _rePasswordController.dispose();
    _addressController.dispose();
    super.dispose();
  }
}
