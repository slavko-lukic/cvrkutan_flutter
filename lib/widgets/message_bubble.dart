import 'package:flutter/material.dart';

import '../constants/colors.dart';

class MessageBubble extends StatelessWidget {
  final String messageText;

  final String messageTimestamp;

  final BoxShadow _bubbleShadow = const BoxShadow(
      color: Colors.black45,
      spreadRadius: 0,
      blurRadius: 2,
      offset: Offset(1, 1));

  final BorderRadiusGeometry _bubbleBorderRadius = const BorderRadius.only(
      topRight: Radius.zero,
      topLeft: Radius.circular(20),
      bottomLeft: Radius.circular(20),
      bottomRight: Radius.circular(20));

  const MessageBubble(
      {required this.messageText, required this.messageTimestamp, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        flex: 3,
        child: Container(
          decoration: BoxDecoration(
              boxShadow: <BoxShadow>[_bubbleShadow],
              color: surfaceColor,
              borderRadius: _bubbleBorderRadius),
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
              const SizedBox(height: 10),
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
