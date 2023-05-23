import 'package:flutter/material.dart';

class CenterContentSomethingLoading extends StatelessWidget {
  const CenterContentSomethingLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SizedBox(
        width: 24,
        height: 24,
        child: CircularProgressIndicator(
          color: Colors.blue,
          strokeWidth: 2,
        ),
      ),
    );
  }
}
