import 'package:flutter/material.dart';
import 'package:roomeasy/app/constant/app_color.dart';
import 'package:roomeasy/app/widget/room_create/room_create_app_bar.dart';
import 'package:roomeasy/app/widget/room_create/room_create_first_step.dart';
import 'package:roomeasy/app/widget/room_create/room_create_step_controls_builder.dart';

class RoomCreate extends StatefulWidget {
  static const routeName = '/room-create';
  const RoomCreate({Key? key}) : super(key: key);

  @override
  _RoomCreateState createState() => _RoomCreateState();
}

class _RoomCreateState extends State<RoomCreate> {
  StepState _getState(int current, int index) {
    if (current == index) return StepState.editing;
    if (current > index) return StepState.complete;
    return StepState.indexed;
  }

  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const RoomCreateAppBar(),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Stepper(
          margin: EdgeInsets.zero,
          controlsBuilder: (BuildContext context, ControlsDetails details) {
            return RoomCreateStepControlsBuilder(details: details);
          },
          currentStep: currentIndex,
          type: StepperType.horizontal,
          elevation: 0,
          steps: [
            Step(
                isActive: currentIndex >= 0,
                state: _getState(currentIndex, 0),
                title: const Text(
                  'Thông tin',
                  style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Colors.black54),
                ),
                content: const Form(child: RoomCreateFirstStep())),
            Step(
                isActive: currentIndex >= 1,
                state: _getState(currentIndex, 1),
                title: const Text(
                  'Địa chỉ',
                  style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Colors.black54),
                ),
                content: Center()),
            Step(
                isActive: currentIndex >= 2,
                state: _getState(currentIndex, 2),
                title: const Text(
                  'Tiện ích',
                  style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Colors.black54),
                ),
                content: Center()),
          ],
          onStepContinue: () {
            if (currentIndex < 3) {
              setState(() {
                currentIndex += 1;
              });
            }
          },
          onStepCancel: () {
            if (currentIndex > 0) {
              setState(() {
                currentIndex -= 1;
              });
            }
          },
        ),
      ),
    );
  }
}
