// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:roomeasy/app/constant/app_color.dart';
import 'package:roomeasy/app/provider/common/profile.dart';
import 'package:roomeasy/app/widget/common/center_content_something_error.dart';
import 'package:roomeasy/app/widget/common/center_content_something_loading.dart';

class ProfileBottomModal extends ConsumerWidget {
  final String userId;
  const ProfileBottomModal({
    Key? key,
    required this.userId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProfileProvider(userId));
    return user.when(
      data: (res) {
        if (!res.code.toString().startsWith('2') || res.data == null) {
          return const CenterContentSomethingError();
        }
        return Container(
          constraints: const BoxConstraints(
            maxHeight: 300,
          ),
          color: AppColor.textBlue,
          padding:
              const EdgeInsets.only(top: 20, bottom: 20, left: 12, right: 12),
          child: Column(
            children: [
              SizedBox(
                width: 100,
                height: 100,
                child: CircleAvatar(
                  backgroundImage:
                      res.data!.avatar == null || res.data!.avatar!.isEmpty
                          ? const AssetImage('assets/images/default_user.png')
                              as ImageProvider
                          : NetworkImage(res.data!.avatar!),
                ),
              ),
              SizedBox(
                  height: 30,
                  child: Text(
                    res.data!.name ?? "Chưa có tên",
                    style: const TextStyle(
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        color: Colors.white),
                  )),
              SizedBox(
                height: 50,
                child: ListTile(
                  leading: const Icon(
                    Icons.email_outlined,
                    size: 24,
                    color: AppColor.primary,
                  ),
                  title: Text(
                    res.data!.email!,
                    style: const TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.white),
                  ),
                ),
              ),
              SizedBox(
                height: 50,
                child: ListTile(
                  leading: const Icon(
                    Icons.phone,
                    size: 24,
                    color: AppColor.primary,
                  ),
                  title: Text(
                    res.data!.phone!,
                    style: const TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        );
      },
      error: (error, stackTrace) => const CenterContentSomethingError(),
      loading: () => const CenterContentSomethingLoading(),
    );
  }
}
