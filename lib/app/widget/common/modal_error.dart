import 'package:flutter/material.dart';

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
            color: Colors.green,
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
        duration: const Duration(seconds: 10),
        backgroundColor: Colors.transparent,
        elevation: 0,
        content: Material(
          elevation: 2,
          borderRadius: BorderRadius.circular(8),
          child: Container(
            width: 200,
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
            child: ListTile(
              horizontalTitleGap: 0,
              visualDensity: const VisualDensity(
                  vertical: VisualDensity.minimumDensity,
                  horizontal: VisualDensity.minimumDensity),
              contentPadding: const EdgeInsets.symmetric(horizontal: 8),
              dense: true,
              leading: icon,
              title: Text(
                message ?? "",
                style: const TextStyle(
                  color: Colors.black87,
                  fontFamily: 'Inter',
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ));

    ScaffoldMessenger.of(context).showSnackBar(child);
  }
}
