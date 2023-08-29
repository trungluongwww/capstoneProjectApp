import 'package:flutter/material.dart';

class PositionCenterLoading extends StatelessWidget {
  const PositionCenterLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Positioned.fill(
        child: Material(
            color: Colors.transparent,
            elevation: 2,
            child: Center(
              child: SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 3,
                ),
              ),
            )));
  }
}
