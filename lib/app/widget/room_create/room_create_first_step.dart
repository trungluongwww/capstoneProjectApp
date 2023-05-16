import 'package:flutter/material.dart';
import 'package:roomeasy/app/widget/room_create/room_create_group_info.dart';
import 'package:roomeasy/app/widget/room_create/room_create_group_type.dart';
import 'package:roomeasy/app/widget/room_create/room_create_radio_input.dart';

class RoomCreateFirstStep extends StatefulWidget {
  const RoomCreateFirstStep({Key? key}) : super(key: key);

  @override
  _RoomCreateFirstStepState createState() => _RoomCreateFirstStepState();
}

class _RoomCreateFirstStepState extends State<RoomCreateFirstStep> {
  // key
  final GlobalKey<RoomCreateGroupTypeState> typeKey =
      GlobalKey<RoomCreateGroupTypeState>();

  // controller
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _rentPerMonthController = TextEditingController();
  final TextEditingController _depositController = TextEditingController();
  final TextEditingController _squareMetreController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _rentPerMonthController.dispose();
    _depositController.dispose();
    _squareMetreController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(bottom: 24.0),
            child: Text(
              'Thông tin phòng',
              style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 18,
                  color: Colors.black,
                  fontWeight: FontWeight.w500),
            ),
          ),
          RoomCreateGroupType(
            key: typeKey,
          ),
          RoomCreateGroupInfo(
            depositController: _depositController,
            descriptionController: _descriptionController,
            nameController: _nameController,
            rentPerMonthController: _rentPerMonthController,
            squareMetreController: _squareMetreController,
          ),
        ],
      ),
    );
  }
}
