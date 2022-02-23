import 'package:flutter/material.dart';

import '../constants/colors.dart';

class MessageText extends StatelessWidget {
  final String messageText;
  final String messageTimestamp;

  const MessageText(
      {required this.messageText, required this.messageTimestamp, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        flex: 3,
        child: Container(
          decoration: const BoxDecoration(
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: Colors.black45,
                    spreadRadius: 0,
                    blurRadius: 2,
                    offset: Offset(1, 1))
              ],
              color: surfaceColor,
              borderRadius: BorderRadius.only(
                  topRight: Radius.zero,
                  topLeft: Radius.circular(20),
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20))),
          width: double.infinity,
          padding: const EdgeInsets.all(15),
          margin: const EdgeInsets.only(right: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                messageText,
                style: const TextStyle(fontSize: 16, color: Colors.black),
                textAlign: TextAlign.start,
              ),
              Text(
                messageTimestamp,
                style: const TextStyle(fontSize: 14, color: Colors.grey),
                textAlign: TextAlign.start,
              ),
            ],
          ),
        ));
  }
}
