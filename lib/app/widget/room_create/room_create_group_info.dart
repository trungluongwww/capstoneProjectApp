// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/number_symbols_data.dart';

import 'package:roomeasy/app/widget/room_create/room_create_text_field_input.dart';

class RoomCreateGroupInfo extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController descriptionController;
  final TextEditingController rentPerMonthController;
  final TextEditingController depositController;
  final TextEditingController squareMetreController;

  const RoomCreateGroupInfo({
    Key? key,
    required this.nameController,
    required this.descriptionController,
    required this.rentPerMonthController,
    required this.depositController,
    required this.squareMetreController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 16),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Tên phòng',
            style: TextStyle(
                color: Colors.black54,
                fontFamily: 'Inter',
                fontSize: 16,
                fontWeight: FontWeight.w400),
          ),
          RoomCreateTextFieldInput(
              controller: nameController,
              validator: (val) {
                if (val == null || val.trim().isEmpty) {
                  return "Vui lòng nhập tên phòng";
                }

                if (val.trim().length < 8) {
                  return "Vui lòng nhập ít nhất 8 ký tự";
                }

                return null;
              },
              hintText: 'Nhập tên phòng',
              keyboardType: TextInputType.text),
          const Text(
            'Mô tả chi tiết',
            style: TextStyle(
                color: Colors.black54,
                fontFamily: 'Inter',
                fontSize: 16,
                fontWeight: FontWeight.w400),
          ),
          RoomCreateTextFieldInput(
              controller: descriptionController,
              validator: (val) {
                if (val == null || val.trim().isEmpty) {
                  return "Vui lòng nhập mô tả chi tiết";
                }

                if (val.trim().length < 8) {
                  return "Vui lòng nhập ít nhất 8 ký tự";
                }

                return null;
              },
              hintText: 'Viết mô tả',
              keyboardType: TextInputType.text),
          const Text(
            'Giá thuê một tháng',
            style: TextStyle(
                color: Colors.black54,
                fontFamily: 'Inter',
                fontSize: 16,
                fontWeight: FontWeight.w400),
          ),
          RoomCreateTextFieldInput(
              inputFormatter: [
                FilteringTextInputFormatter.digitsOnly,
                CurrencyTextInputFormatter(symbol: '', decimalDigits: 0)
              ],
              controller: rentPerMonthController,
              validator: (val) {
                if (val == null || val.trim().isEmpty) {
                  return "Vui lòng nhập giá thuê";
                }

                val = val.replaceAll(',', '');

                final n = num.tryParse(val);
                if (n == null) {
                  return "Giá tiền không hợp lệ";
                }

                if (n > 100000000) {
                  return "Giá tiền phải dưới 100 triệu VNĐ";
                }

                if (n < 100000) {
                  return "Giá tiền ít nhất 100.000 VNĐ";
                }

                return null;
              },
              hintText: 'Nhập số tiền (VNĐ)',
              keyboardType: TextInputType.number),
          const Text(
            'Yêu cầu tiền cọc',
            style: TextStyle(
                color: Colors.black54,
                fontFamily: 'Inter',
                fontSize: 16,
                fontWeight: FontWeight.w400),
          ),
          RoomCreateTextFieldInput(
              inputFormatter: [
                FilteringTextInputFormatter.digitsOnly,
                CurrencyTextInputFormatter(symbol: '', decimalDigits: 0)
              ],
              controller: depositController,
              validator: (val) {
                if (val == null || val.trim().isEmpty) {
                  return "Vui lòng nhập giá tiền";
                }

                val = val.replaceAll(',', '');

                final n = num.tryParse(val);
                if (n == null) {
                  return "Giá tiền không hợp lệ";
                }

                if (n > 100000000) {
                  return "Giá tiền phải dưới 100 triệu VNĐ";
                }

                return null;
              },
              hintText: 'Nhập số tiền (VNĐ)',
              keyboardType: TextInputType.number),
          const Text(
            'Diện tích (m²)',
            style: TextStyle(
                color: Colors.black54,
                fontFamily: 'Inter',
                fontSize: 16,
                fontWeight: FontWeight.w400),
          ),
          RoomCreateTextFieldInput(
              inputFormatter: [FilteringTextInputFormatter.digitsOnly],
              controller: squareMetreController,
              validator: (val) {
                if (val == null || val.trim().isEmpty) {
                  return "Vui lòng nhập diện tích phòng";
                }
                final n = num.tryParse(val);
                if (n == null) {
                  return "Diện tích phòng không hợp lệ";
                }

                if (n > 500) {
                  return "Diện tích phòng phải dưới 500 m²";
                }

                if (n < 5) {
                  return "Diện tích phòng phải trên 5 m²";
                }

                return null;
              },
              hintText: 'Nhập diện tích phòng',
              keyboardType: TextInputType.number),
        ],
      ),
    );
  }
}
