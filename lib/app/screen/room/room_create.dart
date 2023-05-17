import 'package:flutter/material.dart';
import 'package:roomeasy/app/constant/app_color.dart';
import 'package:roomeasy/app/screen/location/location.dart';
import 'package:roomeasy/app/widget/common/modal_error.dart';
import 'package:roomeasy/app/widget/room_create/room_create_app_bar.dart';
import 'package:roomeasy/app/widget/room_create/room_create_group_info.dart';
import 'package:roomeasy/app/widget/room_create/room_create_group_type.dart';
import 'package:roomeasy/app/widget/room_create/room_create_location.dart';
import 'package:roomeasy/app/widget/room_create/room_create_step_controls_builder.dart';
import 'package:roomeasy/app/widget/room_create/room_create_text_field_input.dart';
import 'package:roomeasy/form/location/location.dart';
import 'package:roomeasy/form/room/room_create.dart';

class RoomCreate extends StatefulWidget {
  static const routeName = '/room-create';
  const RoomCreate({Key? key}) : super(key: key);

  @override
  _RoomCreateState createState() => _RoomCreateState();
}

class _RoomCreateState extends State<RoomCreate> {
  // controller step 1
  final TextEditingController _nameController =
      TextEditingController(text: '11111111111111111111');
  final TextEditingController _descriptionController =
      TextEditingController(text: '11111111111111111111');
  final TextEditingController _rentPerMonthController =
      TextEditingController(text: '1000000');
  final TextEditingController _depositController =
      TextEditingController(text: '0');
  final TextEditingController _squareMetreController =
      TextEditingController(text: '25');
  final TextEditingController _addressController = TextEditingController();

  // key step 1
  final GlobalKey<FormState> formKey1 = GlobalKey<FormState>();
  final GlobalKey<FormState> formKey2 = GlobalKey<FormState>();
  final GlobalKey<RoomCreateGroupTypeState> typeKey =
      GlobalKey<RoomCreateGroupTypeState>();

  StepState _getState(int current, int index) {
    if (current == index) return StepState.editing;
    if (current > index) return StepState.complete;
    return StepState.indexed;
  }

  // formdata
  RoomCreateFormModel formdata = RoomCreateFormModel(
      name: '',
      description: '',
      rentPerMonth: 0,
      deposit: 0,
      squareMetre: 0,
      provinceId: '',
      districtId: '',
      wardId: '',
      address: '',
      type: '',
      convenienceIds: [],
      files: []);
  LocationFormModel locationData = LocationFormModel();

  int currentIndex = 0;

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
    _addressController.dispose();
    super.dispose();
  }

  // handler
  void _onSelectedLoation() async {
    var rs = await Navigator.of(context)
        .pushNamed(SelectLocationScreen.routerName, arguments: locationData);

    setState(() {
      locationData = LocationFormModel.fromData(rs);
    });
  }

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
                content: Form(
                  key: formKey1,
                  child: SingleChildScrollView(
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
                  ),
                )),
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
                content: Form(
                    key: formKey2,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          RoomCreateLocation(
                              onSelected: _onSelectedLoation,
                              location: locationData),
                          RoomCreateTextFieldInput(
                              controller: _addressController,
                              validator: (val) {
                                if (val == null || val.trim().isEmpty) {
                                  return "Vui lòng nhập địa chỉ";
                                }

                                if (val.trim().length < 5) {
                                  return "Vui lòng nhập ít nhất 5 ký tự";
                                }

                                return null;
                              },
                              hintText: "Tên đường, số nhà, kiệt/hẻm,...",
                              keyboardType: TextInputType.text)
                        ],
                      ),
                    ))),
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
            // done step 1
            if (currentIndex == 0) {
              if (!formKey1.currentState!.validate()) {
                return;
              }

              if (typeKey.currentState!.finalValue.isEmpty) {
                ModalError()
                    .showToast(context, '400', 'Vui lòng chọn loại phòng');
                return;
              }

              setState(() {
                formdata = formdata.copyWith(
                    type: typeKey.currentState!.finalValue,
                    name: _nameController.value.text,
                    description: _descriptionController.value.text,
                    rentPerMonth: int.tryParse(
                        _rentPerMonthController.value.text.replaceAll(',', '')),
                    deposit: int.tryParse(
                        _depositController.value.text.replaceAll(',', '')),
                    squareMetre:
                        int.tryParse(_squareMetreController.value.text));
              });
            }

            // done step 2
            if (currentIndex == 1) {
              if (!formKey2.currentState!.validate()) {
                return;
              }

              // validate location
              if (locationData.provinceId == null ||
                  locationData.districtId == null ||
                  locationData.wardId == null) {
                ModalError().showToast(
                    context, '400', "Vui lòng chọn thông tin địa chỉ");
                return;
              }

              setState(() {
                formdata = formdata.copyWith(
                    address: _addressController.value.text,
                    provinceId: locationData.provinceId,
                    districtId: locationData.districtId,
                    wardId: locationData.wardId);
              });
            }

            if (currentIndex < 2) {
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
