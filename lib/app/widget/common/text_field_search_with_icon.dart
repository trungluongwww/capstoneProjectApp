// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:roomeasy/app/constant/app_color.dart';

class TextFieldSearchWithIcon extends StatelessWidget {
  final VoidCallback onSubmited;
  final TextEditingController searchController;
  final String hintText;
  final int maxLength;

  const TextFieldSearchWithIcon({
    Key? key,
    required this.onSubmited,
    required this.searchController,
    required this.hintText,
    this.maxLength = 50,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: AppColor.appDarkWhiteColor,
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 5.0),
            child: IconButton(
                onPressed: onSubmited,
                icon: const Icon(Icons.search),
                color: Colors.grey),
          ),
          Expanded(
            child: TextField(
              maxLength: maxLength,
              controller: searchController,
              onSubmitted: (val) => onSubmited(),
              decoration: InputDecoration(
                counterText: "",
                hintText: hintText,
                hintStyle: TextStyle(
                  color: Colors.grey.withOpacity(0.8),
                  fontStyle: Theme.of(context).textTheme.bodyMedium!.fontStyle,
                ),
                border: InputBorder.none,
              ),
            ),
          ),
          const Padding(padding: EdgeInsets.only(left: 15))
        ],
      ),
    );
  }
}
