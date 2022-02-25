import 'package:cvrkutan_flutter/widgets/message_bubble.dart';
import 'package:cvrkutan_flutter/widgets/message_user_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/message.dart';

class MessageBlock extends StatelessWidget {
  static const _leftOffset = Offset(-2.5, 0.0);
  static const _rightOffset = Offset(2.5, 0.0);
  static const _endPosition = Offset(0.0, 0.0);

  final Message message;
  final Animation<double> animation;

  const MessageBlock({required this.message, required this.animation, Key? key})
      : super(key: key);

  Future<String> getCurrentUsername() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    String? _username = pref.getString('username');

    return _username ?? 'anonymous';
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getCurrentUsername(),
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          if (snapshot.hasData) {
            return SlideTransition(
              position: Tween<Offset>(
                begin: message.username == snapshot.data
                    ? _leftOffset
                    : _rightOffset,
                end: _endPosition,
              ).animate(CurvedAnimation(
                parent: animation,
                curve: Curves.decelerate,
              )),
              child: Container(
                margin: const EdgeInsets.fromLTRB(20, 20, 20, 10),
                child: message.username == snapshot.data
                    ? Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                            MessageUserInfo(
                                username: message.username,
                                picture: message.picture),
                            MessageBubble(
                                messageText: message.message,
                                messageTimestamp: message.timestamp)
                          ])
                    : Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                            MessageBubble(
                                messageText: message.message,
                                messageTimestamp: message.timestamp),
                            MessageUserInfo(
                                username: message.username,
                                picture: message.picture)
                          ]),
              ),
            );
          } else {
            return Container();
          }
        });
  }
}
