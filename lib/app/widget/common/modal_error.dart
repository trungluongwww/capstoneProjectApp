import 'package:flutter/material.dart';
import 'package:roomeasy/app/constant/app_color.dart';

class ModalError {
  static final ModalError _instance = ModalError._internal();

  factory ModalError() {
    return _instance;
  }

  ModalError._internal();

  void showToast(BuildContext context, String code, String? message) {
    Widget icon = code.startsWith('2')
        ? const Icon(
            Icons.done,
            color: AppColor.lightPrimary,
            size: 24,
            weight: 16,
          )
        : const Icon(
            Icons.error,
            color: Colors.red,
            size: 24,
            weight: 16,
          );
    SnackBar child = SnackBar(
        duration: const Duration(seconds: 3),
        backgroundColor: AppColor.textBlue,
        elevation: 0,
        content: Material(
            elevation: 0,
            borderRadius: BorderRadius.circular(8),
            color: AppColor.textBlue,
            child: Row(
              children: [
                icon,
                const SizedBox(
                  width: 12,
                ),
                Expanded(
                  child: Text(
                    message ?? "",
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,
                    style: const TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            )));

    ScaffoldMessenger.of(context).showSnackBar(child);
  }
}
