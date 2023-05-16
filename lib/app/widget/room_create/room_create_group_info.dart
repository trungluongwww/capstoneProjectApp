// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

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
      padding: EdgeInsets.only(top: 16),
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
              validator: (val) {},
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
              validator: (val) {},
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
              controller: rentPerMonthController,
              validator: (val) {},
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
              controller: depositController,
              validator: (val) {},
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
              controller: squareMetreController,
              validator: (val) {},
              hintText: 'Nhập diện tích phòng',
              keyboardType: TextInputType.number),
        ],
      ),
    );
  }
}
