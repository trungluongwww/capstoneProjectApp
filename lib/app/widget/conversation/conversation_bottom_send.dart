import 'package:flutter/material.dart';
import 'package:roomeasy/app/constant/app_color.dart';

class ConversationBottomSend extends StatefulWidget {
  const ConversationBottomSend({Key? key}) : super(key: key);

  @override
  _ConversationBottomSendState createState() => _ConversationBottomSendState();
}

class _ConversationBottomSendState extends State<ConversationBottomSend> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      color: Colors.white,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          InkWell(
            onTap: () {},
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(
                Icons.add_a_photo_outlined,
                color: Colors.black54,
                size: 20,
              ),
            ),
          ),
          Expanded(
            child: TextFormField(
              validator: (val) {
                return null;
              },
              style: const TextStyle(
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  color: Colors.black87),
              decoration: const InputDecoration(
                  hintText: "Tin nhắn ...",
                  hintStyle: TextStyle(color: Colors.black54),
                  border: InputBorder.none),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(right: 4),
            width: 40,
            height: 40,
            child: FloatingActionButton(
              onPressed: () {},
              backgroundColor: Colors.blue,
              elevation: 0,
              child: const Icon(
                Icons.send,
                color: Colors.white,
                size: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
