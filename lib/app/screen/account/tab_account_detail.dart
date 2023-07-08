import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:roomeasy/api/services/auth/auth.dart';
import 'package:roomeasy/api/services/upload/upload.dart';
import 'package:roomeasy/app/constant/app_color.dart';
import 'package:roomeasy/app/provider/common/auth.dart';
import 'package:roomeasy/app/screen/common/no_network_screen.dart';
import 'package:roomeasy/app/screen/location/location.dart';
import 'package:roomeasy/app/widget/account/account_form_location.dart';
import 'package:roomeasy/app/widget/account/account_text_field_input.dart';
import 'package:roomeasy/app/widget/common/button_text_primary.dart';
import 'package:roomeasy/app/widget/common/center_content_something_loading.dart';
import 'package:roomeasy/app/widget/common/modal_error.dart';
import 'package:roomeasy/form/location/location.dart';
import 'package:roomeasy/form/user/user_change_avatar.dart';
import 'package:roomeasy/form/user/user_update.dart';

class TabAccountDetail extends ConsumerStatefulWidget {
  const TabAccountDetail({Key? key}) : super(key: key);

  @override
  ConsumerState createState() => _TabAccountDetailState();
}

class _TabAccountDetailState extends ConsumerState<TabAccountDetail> {
  late TextEditingController _nameController;
  late TextEditingController _addressController;
  late LocationFormModel _locationData;
  late GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // state
  bool _isSubmited = false;

  XFile? _avatarFile;

  @override
  void initState() {
    _locationData = LocationFormModel();
    _nameController = TextEditingController();
    _addressController = TextEditingController();

    prepareInfo();
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  // handler
  void _onSelectedLoation() async {
    var rs = await Navigator.of(context)
        .pushNamed(SelectLocationScreen.routerName, arguments: _locationData);

    setState(() {
      _locationData = LocationFormModel.fromData(rs);
    });
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(authProfileProvider, (previous, next) {
      if (next != null) {
        prepareInfo();
      }
    });
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: double.infinity,
          padding: const EdgeInsets.only(top: 24, left: 12, right: 12),
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  SizedBox(
                    width: 100,
                    height: 100,
                    child: CircleAvatar(
                      backgroundImage: _avatarFile == null
                          ? const AssetImage('assets/images/default_user.png')
                          : NetworkImage(_avatarFile!.path) as ImageProvider,
                    ),
                  ),
                  Consumer(
                    builder: (context, ref, child) => TextButton(
                        onPressed: () async {
                          if (!_isSubmited) {
                            final img = await ImagePicker()
                                .pickImage(source: ImageSource.gallery);
                            if (img != null) {
                              setState(() {
                                _isSubmited = true;
                              });

                              final resUpload = await UploadService()
                                  .uploadAvatar(File(img.path));
                              if (!resUpload.code.toString().startsWith('2')) {
                                if (mounted) {
                                  ModalError().showToast(
                                      context,
                                      resUpload.code.toString(),
                                      resUpload.message!);
                                }

                                if (resUpload.code.toString().startsWith('5') &&
                                    mounted) {
                                  Navigator.of(context).pushNamedAndRemoveUntil(
                                      NoNetworkScreen.routerName,
                                      (Route route) => false);
                                }
                                return;
                              }

                              final resUpdate = await AuthServices()
                                  .updateAvatar(UserChangeAvatarFormModel(
                                      avatar: resUpload.data!.url!));

                              if (mounted) {
                                ModalError().showToast(
                                    context,
                                    resUpdate.code.toString(),
                                    resUpdate.message!);
                              }

                              ref.read(authProfileProvider.notifier).refresh();

                              setState(() {
                                if (resUpdate.code.toString().startsWith('2')) {
                                  _avatarFile = XFile(resUpload.data!.url!);
                                }
                                _isSubmited = false;
                              });
                            }
                          }
                        },
                        child: const Text(
                          'Thay đổi ảnh đại diện',
                          style: TextStyle(
                              color: AppColor.primary,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w400,
                              fontSize: 14),
                        )),
                  ),
                  AccountTextFieldInput(
                      controller: _nameController,
                      validator: (val) {
                        if (val == null || val.trim().isEmpty) {
                          return "Vui lòng nhập tên";
                        }

                        if (val.length < 5) {
                          return "Vui lòng nhập ít nhất 5 ký tự";
                        }
                        return null;
                      },
                      hintText: 'Nhập tên',
                      name: 'Tên'),
                  AccountFormLocation(
                      onSelected: _onSelectedLoation, location: _locationData),
                  AccountTextFieldInput(
                      controller: _addressController,
                      validator: (val) {
                        if (val == null || val.trim().isEmpty) {
                          return "Vui lòng nhập địa chỉ";
                        }

                        if (val.length < 8) {
                          return "Vui lòng nhập ít nhất 8 ký tự";
                        }
                        return null;
                      },
                      hintText: 'Nhập địa chỉ',
                      name: 'Địa chỉ'),
                  Padding(
                      padding: const EdgeInsets.only(top: 32),
                      child: Consumer(
                        builder: (context, ref, child) => ButtonTextPrimary(
                            height: 40,
                            onClick: () async {
                              if (!_isSubmited) {
                                setState(() {
                                  _isSubmited = true;
                                });

                                if (formKey.currentState!.validate()) {
                                  String err = "";
                                  int code = 200;

                                  if (!_locationData.isValid()) {
                                    err = "Vui lòng chọn địa chỉ";
                                    code = 400;
                                  }
                                  if (code.toString().startsWith('2')) {
                                    final res = await AuthServices()
                                        .updateProfile(UserUpdateFormModel(
                                            name: _nameController.text,
                                            address: _addressController.text,
                                            provinceId:
                                                _locationData.provinceId!,
                                            districtId:
                                                _locationData.districtId!,
                                            wardId: _locationData.wardId!));
                                    if (res.code.toString().startsWith('2')) {
                                      ref
                                          .read(authProfileProvider.notifier)
                                          .refresh();
                                    }
                                    err = res.message!;
                                    code = res.code!;
                                  }

                                  if (mounted) {
                                    ModalError().showToast(
                                        context, code.toString(), err);
                                  }

                                  setState(() {
                                    _isSubmited = false;
                                  });
                                }
                              }
                            },
                            title: "Cập nhập"),
                      )),
                ],
              ),
            ),
          ),
        ),
        if (_isSubmited)
          const Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(color: Colors.black38),
              child: CenterContentSomethingLoading(),
            ),
          )
      ],
    );
  }

  void prepareInfo() async {
    final user = AuthServices().getCurrentUserState();
    if (user == null) {
      return;
    }
    setState(() {
      _locationData = _locationData.copyWith(
          districtId: user.district!.id,
          districtName: user.district!.name,
          provinceId: user.province!.id,
          provinceName: user.province!.name,
          wardId: user.ward!.id,
          wardName: user.ward!.name);

      _nameController.text = user.name ?? "";
      _addressController.text = user.address ?? "";

      _avatarFile = user.avatar != null && user.avatar!.isNotEmpty
          ? XFile(user.avatar!)
          : null;
    });
  }
}
