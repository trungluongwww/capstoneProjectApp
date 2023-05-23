// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class AccountTextFieldInput extends StatefulWidget {
  final TextEditingController controller;
  final String? Function(String?) validator;
  final String hintText;
  final String name;

  const AccountTextFieldInput({
    Key? key,
    required this.controller,
    required this.validator,
    required this.hintText,
    required this.name,
  }) : super(key: key);

  @override
  _AccountTextFieldInputState createState() => _AccountTextFieldInputState();
}

class _AccountTextFieldInputState extends State<AccountTextFieldInput> {
  late FocusNode _focusNode;
  bool _isFocused = false;

  @override
  void initState() {
    _focusNode = FocusNode();
    _focusNode.addListener(_handleFocusChange);
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _focusNode.removeListener(_handleFocusChange);
    _focusNode.dispose();
    super.dispose();
  }

  // handler
  void _handleFocusChange() {
    setState(() {
      _isFocused = _focusNode.hasFocus;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 12, bottom: 12),
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            width: 0.5,
            color: _isFocused ? Colors.lightBlue : Colors.black54,
          ),
          boxShadow: _isFocused
              ? const [BoxShadow(color: Colors.blue, blurRadius: 2)]
              : null,
          borderRadius: BorderRadius.circular(8)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.name,
            style: Theme.of(context)
                .textTheme
                .titleMedium!
                .copyWith(color: Colors.black87),
          ),
          TextFormField(
            controller: widget.controller,
            style:
                Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: 18),
            validator: widget.validator,
            decoration: InputDecoration(
                errorStyle: const TextStyle(
                    color: Colors.red,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                    overflow: TextOverflow.ellipsis),
                hintText: widget.hintText,
                border: InputBorder.none),
            focusNode: _focusNode,
          ),
        ],
      ),
    );
  }
}
