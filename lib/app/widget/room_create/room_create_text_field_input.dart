import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:roomeasy/app/constant/app_color.dart';

class RoomCreateTextFieldInput extends StatelessWidget {
  final TextEditingController controller;
  final String? Function(String?) validator;
  final String hintText;
  final TextInputType keyboardType;
  final List<TextInputFormatter>? inputFormatter;
  final int? maxLength;

  const RoomCreateTextFieldInput(
      {Key? key,
      required this.controller,
      required this.validator,
      required this.hintText,
      required this.keyboardType,
      this.maxLength = 64,
      this.inputFormatter})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLength: maxLength,
      maxLines: null,
      controller: controller,
      validator: validator,
      keyboardType: keyboardType,
      inputFormatters: inputFormatter,
      style: const TextStyle(
        color: Colors.black87,
        fontSize: 16,
        fontFamily: 'Inter',
        fontWeight: FontWeight.w300,
      ),
      decoration: InputDecoration(
          hintText: hintText,
          border: const UnderlineInputBorder(),
          focusColor: AppColor.primary,
          floatingLabelAlignment: FloatingLabelAlignment.start,
          errorStyle: const TextStyle(
              color: Colors.red,
              fontSize: 12,
              fontStyle: FontStyle.italic,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w400)),
    );
  }
}
