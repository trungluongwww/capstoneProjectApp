// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:roomeasy/app/constant/app_color.dart';

import 'package:roomeasy/form/location/location.dart';

class RoomCreateLocation extends StatelessWidget {
  final VoidCallback onSelected;
  final LocationFormModel location;
  const RoomCreateLocation({
    Key? key,
    required this.onSelected,
    required this.location,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(width: 0.5, color: Colors.black38)),
      padding: const EdgeInsets.only(top: 12, left: 12, right: 12, bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            contentPadding: EdgeInsets.zero,
            title: const Text(
              'Thông tin địa chỉ',
              style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Colors.black),
            ),
            trailing: TextButton(
                onPressed: onSelected,
                child: const Text(
                  'Chọn',
                  style: TextStyle(color: AppColor.primary),
                )),
          ),
          Text(
            location.toString().isNotEmpty ? location.toString() : "Chưa chọn",
            style: const TextStyle(
                fontFamily: 'Inter',
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Colors.red),
          ),
        ],
      ),
    );
  }
}
