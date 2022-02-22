import 'package:cvrkutan_flutter/widgets/messageText.dart';
import 'package:cvrkutan_flutter/widgets/messageUserData.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../models/message.dart';

class MessageFull extends StatelessWidget {
  final Message message;
  const MessageFull({required this.message, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 20, 20, 10),
      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        MessageText(
            messageText: message.message, messageTimestamp: message.timestamp),
        MessageUserData(username: message.username, picture: message.picture)
      ]),
    );
  }
}
