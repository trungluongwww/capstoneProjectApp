import 'package:flutter/material.dart';

class RoomCreate extends StatefulWidget {
  static const routeName = '/room-create';
  const RoomCreate({Key? key}) : super(key: key);

  @override
  _RoomCreateState createState() => _RoomCreateState();
}

class _RoomCreateState extends State<RoomCreate> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Stepper(
          currentStep: 0,
          type: StepperType.horizontal,
          steps: const [
            Step(title: Text('step 1'), content: Text('step 1')),
            Step(title: Text('step 1'), content: Text('step 1')),
            Step(title: Text('step 1'), content: Text('step 1'))
          ],
        ),
      ),
    );
  }
}
