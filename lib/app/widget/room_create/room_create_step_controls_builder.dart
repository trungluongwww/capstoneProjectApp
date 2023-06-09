// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:roomeasy/app/constant/app_color.dart';

class RoomCreateStepControlsBuilder extends StatelessWidget {
  final ControlsDetails details;
  const RoomCreateStepControlsBuilder({
    Key? key,
    required this.details,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        if (details.stepIndex != 0)
          TextButton(
            onPressed: details.onStepCancel,
            child: const Text(
              'Quay lại',
              style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 14,
                  color: Colors.black87,
                  fontWeight: FontWeight.w600),
            ),
          ),
        TextButton(
          onPressed: details.onStepContinue,
          child: Text(
            details.stepIndex == 2 ? 'Xong' : 'Tiếp tục',
            style: const TextStyle(
                fontFamily: 'Inter',
                fontSize: 14,
                color: AppColor.primary,
                fontWeight: FontWeight.w600),
          ),
        ),
      ],
    );
  }
}
