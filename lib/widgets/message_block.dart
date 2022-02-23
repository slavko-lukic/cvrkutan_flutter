import 'package:cvrkutan_flutter/widgets/message_bubble.dart';
import 'package:cvrkutan_flutter/widgets/message_user_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../models/message.dart';

class MessageBlock extends StatelessWidget {
  final Message message;

  final Animation<double> animation;

  final Tween<Offset> _offset = Tween<Offset>(
    begin: const Offset(2.5, 0.0),
    end: const Offset(0.0, 0.0),
  );

  MessageBlock({required this.message, required this.animation, Key? key})
      : super(key: key) {
    if (message.username == 'dr_geller') {
      _offset.begin = const Offset(-2.5, 0.0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _offset.animate(CurvedAnimation(
        parent: animation,
        curve: Curves.decelerate,
      )),
      child: Container(
        margin: const EdgeInsets.fromLTRB(20, 20, 20, 10),
        child: message.username == 'dr_geller'
            ? Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                MessageUserInfo(
                    username: message.username, picture: message.picture),
                MessageBubble(
                    messageText: message.message,
                    messageTimestamp: message.timestamp)
              ])
            : Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                MessageBubble(
                    messageText: message.message,
                    messageTimestamp: message.timestamp),
                MessageUserInfo(
                    username: message.username, picture: message.picture)
              ]),
      ),
    );
  }
}
