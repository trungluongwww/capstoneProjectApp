// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class RoomCreateRadioInput extends StatelessWidget {
  final String title;
  final String value;
  final String groupValue;
  final Function(dynamic) onChange;

  const RoomCreateRadioInput({
    Key? key,
    required this.title,
    required this.value,
    required this.groupValue,
    required this.onChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      width: double.infinity,
      height: 40,
      decoration: const BoxDecoration(
          border:
              Border(bottom: BorderSide(width: 0.5, color: Colors.black45))),
      child: RadioListTile(
        onChanged: onChange,
        visualDensity: const VisualDensity(
            vertical: VisualDensity.minimumDensity,
            horizontal: VisualDensity.minimumDensity),
        contentPadding: EdgeInsets.zero,
        dense: true,
        title: Text(
          title,
          style: const TextStyle(
              fontFamily: 'Inter',
              fontWeight: FontWeight.w400,
              fontSize: 16,
              color: Colors.black54),
        ),
        value: value,
        groupValue: groupValue,
      ),
    );
  }
}
