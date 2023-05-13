import 'package:flutter/material.dart';

class ModalError {
  static final ModalError _instance = ModalError._internal();

  factory ModalError() {
    return _instance;
  }

  ModalError._internal();

  SnackBar showToast(int code, String message) {
    Widget _icon = code.toString().startsWith('2')
        ? const Icon(Icons.done, color: Colors.green, size: 16)
        : const Icon(Icons.error, color: Colors.red, size: 16);
    return SnackBar(
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
              leading: _icon,
              title: Text(
                message,
                style: const TextStyle(
                  color: Colors.black87,
                  fontFamily: 'Inter',
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
        ));
  }
}
