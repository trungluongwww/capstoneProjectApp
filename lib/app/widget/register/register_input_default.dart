import 'package:flutter/material.dart';
import 'package:roomeasy/app/constant/app_color.dart';

class RegisterInputDefault extends StatelessWidget {
  final TextEditingController controller;
  final String? Function(String?) validator;
  final String hintText;
  final String labelText;
  final TextInputType keyboardType;
  const RegisterInputDefault(
      {Key? key,
      required this.controller,
      required this.validator,
      required this.hintText,
      required this.labelText,
      required this.keyboardType})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLength: 64,
      controller: controller,
      validator: validator,
      keyboardType: keyboardType,
      style: const TextStyle(
        color: Colors.black87,
        fontSize: 16,
        fontFamily: 'Inter',
        fontWeight: FontWeight.w300,
      ),
      decoration: InputDecoration(
          hintText: hintText,
          labelText: labelText,
          border: const UnderlineInputBorder(),
          focusColor: AppColor.appPrimaryColor,
          labelStyle: const TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w300,
          ),
          errorStyle: const TextStyle(
              color: Colors.red,
              fontSize: 12,
              fontStyle: FontStyle.italic,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w400)),
    );
  }
}
