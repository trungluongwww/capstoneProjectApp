// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:roomeasy/api/services/auth/auth.dart';

import 'package:roomeasy/api/services/convenience/convenience.dart';
import 'package:roomeasy/api/services/room/room.dart';
import 'package:roomeasy/api/services/upload/upload.dart';
import 'package:roomeasy/app/constant/app_color.dart';
import 'package:roomeasy/app/constant/app_icon.dart';
import 'package:roomeasy/app/screen/location/location.dart';
import 'package:roomeasy/app/widget/common/center_content_something_loading.dart';
import 'package:roomeasy/app/widget/common/list_title_small_without_spacing.dart';
import 'package:roomeasy/app/widget/common/modal_error.dart';
import 'package:roomeasy/app/widget/room_create/room_create_app_bar.dart';
import 'package:roomeasy/app/widget/room_create/room_create_group_info.dart';
import 'package:roomeasy/app/widget/room_create/room_create_group_type.dart';
import 'package:roomeasy/app/widget/room_create/room_create_location.dart';
import 'package:roomeasy/app/widget/room_create/room_create_step_controls_builder.dart';
import 'package:roomeasy/app/widget/room_create/room_create_text_field_input.dart';
import 'package:roomeasy/form/file/file.dart';
import 'package:roomeasy/form/location/location.dart';
import 'package:roomeasy/form/room/room_remove_photo.dart';
import 'package:roomeasy/form/room/room_update.dart';

import 'package:roomeasy/model/convenience/convenience.dart';
import 'package:roomeasy/model/room/room_file.dart';

class RoomUpdateScreen extends StatefulWidget {
  static const routeName = '/room-update';
  final String roomId;
  const RoomUpdateScreen({
    Key? key,
    required this.roomId,
  }) : super(key: key);

  @override
  _RoomUpdateScreenState createState() => _RoomUpdateScreenState();
}

class _RoomUpdateScreenState extends State<RoomUpdateScreen> {
  // config
  final maxFile = 4;

  // controller step 1
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _rentPerMonthController = TextEditingController();
  final TextEditingController _depositController = TextEditingController();
  final TextEditingController _squareMetreController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  //
  // state
  //

  // convenience
  List<ConvenienceModel> _conveniences = [];
  bool isLoadingConvenience = false;
  List<String> selectedConveniences = [];

  // file
  List<RoomFileModel> selectedFiles = [];

  // step
  int currentIndex = 0;

  // loading
  bool isGlobalLoading = false;

  //
  // key
  //
  final GlobalKey<FormState> formKey1 = GlobalKey<FormState>();
  final GlobalKey<FormState> formKey2 = GlobalKey<FormState>();
  final GlobalKey<RoomCreateGroupTypeState> typeKey =
      GlobalKey<RoomCreateGroupTypeState>();

  StepState _getState(int current, int index) {
    if (current == index) return StepState.editing;
    if (current > index) return StepState.complete;
    return StepState.indexed;
  }

  // form data
  LocationFormModel locationData = LocationFormModel();

  // formdata
  RoomUpdateFormModel formdata = RoomUpdateFormModel(
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
  );

  @override
  void initState() {
    super.initState();
    _fetchConvenience();
    _fetchRoom();
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

  void _removeFileSelected(BuildContext context, String id) async {
    if (selectedFiles.length <= 1) {
      if (mounted) {
        ModalError().showToast(
            context, "400", "Ít nhất 1 hình, chọn hình ảnh khác thay thế !");
      }
      return;
    }

    setState(() {
      isGlobalLoading = true;
    });

    final res = await RoomServices().removePhoto(
        roomId: widget.roomId, formdata: RoomRemovePhotoFormModel(fileId: id));

    if (res.code.toString().startsWith('2')) {
      setState(() {
        selectedFiles.removeWhere((element) => element.id == id);
      });
    }

    if (mounted) {
      ModalError().showToast(context, res.code.toString(), res.message ?? "");
    }

    setState(() {
      isGlobalLoading = false;
    });
  }

  void _addFileSelected() async {
    final f = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (f != null) {
      setState(() {
        isGlobalLoading = true;
      });

      final res = await UploadService().uploadSinglePhoto(File(f.path));

      if (res.isSuccess() && res.isValidData()) {
        final res2 = await RoomServices().addPhoto(
            roomId: widget.roomId,
            formdata: FileFormModel(
                height: res.data!.height,
                name: res.data!.name,
                originName: res.data!.originName,
                type: res.data!.type,
                url: res.data!.url,
                width: res.data!.width));
        if (res2.isSuccess()) {
          if (mounted) {
            ModalError().showToast(context, res2.code.toString(), res2.message);
          }

          setState(() {
            selectedFiles.add(RoomFileModel(
                createdAt: DateTime.now(), id: res2.data!.id, info: res.data));
          });
        }
      } else {
        if (mounted) {
          ModalError().showToast(context, res.code.toString(), res.message);
        }
      }

      setState(() {
        isGlobalLoading = false;
      });
    }
  }

  //
  // fetch
  //

  void _fetchConvenience() async {
    if (!isLoadingConvenience) {
      setState(() {
        isLoadingConvenience = true;
      });

      final res = await ConvenienceService().getAll();

      if (res.code.toString().startsWith('2') && res.data != null) {
        setState(() {
          _conveniences = res.data!.conveniences;
        });
      }

      setState(() {
        isLoadingConvenience = false;
      });
    }
  }

  void _fetchRoom() async {
    setState(() {
      isGlobalLoading = true;
    });

    final res = await RoomServices().getDetailRoom(id: widget.roomId);
    if (res.data != null) {
      _nameController.text = res.data!.name ?? "";
      _descriptionController.text = res.data!.description ?? "";
      _rentPerMonthController.text = res.data!.rentPerMonth.toString();
      _depositController.text = res.data!.deposit.toString();
      _squareMetreController.text = res.data!.squareMetre.toString();
      _addressController.text = res.data!.address ?? "";

      setState(() {
        selectedFiles = res.data!.files;

        for (var element in res.data!.conveniences) {
          selectedConveniences.add(element.id!);
        }

        locationData = locationData.copyWith(
          districtId: res.data!.district!.id,
          districtName: res.data!.district!.name,
          provinceId: res.data!.province!.id,
          provinceName: res.data!.province!.name,
          wardId: res.data!.ward!.id,
          wardName: res.data!.ward!.name,
        );
      });
    }

    setState(() {
      isGlobalLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const RoomCreateAppBar(),
      body: Stack(
        children: [
          SizedBox(
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
                // step 1
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
                    content: Consumer(builder: (context, ref, child) {
                      return SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // photo
                            const Text(
                              'Chọn hình ảnh',
                              style: TextStyle(
                                  fontFamily: 'Inter',
                                  fontSize: 16,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400),
                            ),
                            const Padding(
                                padding: EdgeInsets.only(bottom: 8),
                                child: Text(
                                  '(Tối đa 4 hình)',
                                  style: TextStyle(
                                      fontFamily: 'Inter',
                                      fontSize: 12,
                                      color: Colors.red,
                                      fontWeight: FontWeight.w300),
                                )),

                            Flexible(
                                child: GridView(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              scrollDirection: Axis.vertical,
                              padding: EdgeInsets.zero,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 3,
                                      crossAxisSpacing: 8,
                                      mainAxisSpacing: 8,
                                      childAspectRatio: 1),
                              children: [
                                ...selectedFiles
                                    .map((f) => Stack(children: [
                                          Container(
                                              clipBehavior: Clip.hardEdge,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(8)),
                                              width: double.infinity,
                                              height: double.infinity,
                                              child: CachedNetworkImage(
                                                fit: BoxFit.cover,
                                                imageUrl: f.info!.url!,
                                                placeholder: (context, url) =>
                                                    const CenterContentSomethingLoading(),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        const Icon(Icons.error),
                                              )),
                                          Positioned(
                                              top: 0,
                                              right: 0,
                                              child: IconButton(
                                                  color: Colors.red,
                                                  iconSize: 24,
                                                  onPressed: () =>
                                                      _removeFileSelected(
                                                          context, f.id!),
                                                  icon: const Icon(
                                                      Icons.cancel_outlined))),
                                        ]))
                                    .toList(),
                                if (selectedFiles.length != maxFile)
                                  DecoratedBox(
                                    decoration: BoxDecoration(
                                        color: Colors.black12,
                                        borderRadius: BorderRadius.circular(8)),
                                    child: IconButton(
                                      onPressed: _addFileSelected,
                                      icon: const Icon(
                                          Icons.add_photo_alternate_outlined),
                                    ),
                                  )
                              ],
                            )),
                            // convenience
                            const Padding(
                                padding: EdgeInsets.only(top: 32, bottom: 8),
                                child: Text(
                                  'Chọn tiện ích có sẵn',
                                  style: TextStyle(
                                      fontFamily: 'Inter',
                                      fontSize: 16,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w400),
                                )),
                            Flexible(
                              child: GridView(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                scrollDirection: Axis.vertical,
                                padding: EdgeInsets.zero,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        crossAxisSpacing: 8,
                                        mainAxisSpacing: 8,
                                        childAspectRatio: 4),
                                children: _conveniences.map((conv) {
                                  return Container(
                                    padding: const EdgeInsets.all(4),
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        color: selectedConveniences
                                                .contains(conv.id!)
                                            ? Colors.white70
                                            : AppColor.appDarkWhiteColor,
                                        border: selectedConveniences
                                                .contains(conv.id!)
                                            ? Border.all(
                                                width: 1, color: Colors.blue)
                                            : null,
                                        borderRadius: BorderRadius.circular(6)),
                                    child: InkWell(
                                      onTap: () {
                                        if (!selectedConveniences
                                            .contains(conv.id)) {
                                          setState(() {
                                            selectedConveniences.add(conv.id!);
                                          });
                                        } else {
                                          setState(() {
                                            selectedConveniences
                                                .remove(conv.id!);
                                          });
                                        }
                                      },
                                      child: ListTitleSmallWithoutSpacing(
                                        defaultTitle: conv.name!,
                                        leadIcon: AppIcon()
                                                .getIconDataByKey(conv.code!) ??
                                            Icons.help_outline,
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                          ],
                        ),
                      );
                    })),
              ],
              onStepContinue: () async {
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
                        rentPerMonth: int.tryParse(_rentPerMonthController
                            .value.text
                            .replaceAll(',', '')),
                        deposit: int.tryParse(
                            _depositController.value.text.replaceAll(',', '')),
                        squareMetre:
                            int.tryParse(_squareMetreController.value.text));
                  });
                }

                // step 2
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

                  _fetchConvenience();
                }

                // done step 3, submit
                if (currentIndex == 2) {
                  String errMsg = '';
                  int code = 200;

                  if (!isGlobalLoading) {
                    setState(() {
                      isGlobalLoading = true;
                    });

                    if (selectedFiles.isEmpty) {
                      errMsg = "Vui lòng chọn ít nhất một hình ảnh";
                      code = 400;
                    }

                    if (errMsg.isEmpty) {
                      final result = await RoomServices()
                          .update(id: widget.roomId, formdata: formdata);
                      errMsg = result.message ?? 'Lỗi không xác định';
                      code = result.code ?? 400;
                    }

                    if (mounted && errMsg.isNotEmpty) {
                      ModalError().showToast(context, code.toString(), errMsg);
                      setState(() {
                        isGlobalLoading = false;
                      });
                    }

                    if (code.toString().startsWith('2') && mounted) {
                      Navigator.pop(context);
                    }

                    setState(() {
                      isGlobalLoading = false;
                    });
                  }
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
          if (isGlobalLoading)
            Positioned.fill(
                child: Container(
              color: Colors.black12,
              child: const Center(
                child: SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(
                    color: AppColor.appBlurPrimaryColor,
                  ),
                ),
              ),
            ))
        ],
      ),
    );
  }
}
