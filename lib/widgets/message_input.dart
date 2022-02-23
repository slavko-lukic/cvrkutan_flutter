import 'package:flutter/material.dart';

import '../constants/colors.dart';

class MessageInput extends StatelessWidget {
  final TextEditingController _newMessageController = TextEditingController();

  final OutlineInputBorder _inputBoxBorder = OutlineInputBorder(
      borderSide: const BorderSide(color: primaryColor, width: 1),
      borderRadius: BorderRadius.circular(50));

  final BoxShadow _containerTopShadow = const BoxShadow(
      color: Colors.black45,
      spreadRadius: 0,
      blurRadius: 3,
      offset: Offset(0, -1));

  MessageInput({Key? key}) : super(key: key);

  void onMessageSend() {
    if (_newMessageController.text == '') return;

    // _newMessageController.text
    // send new message api call to server

    _newMessageController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding:
            const EdgeInsets.only(bottom: 30, left: 20, right: 20, top: 20),
        decoration: BoxDecoration(
          color: surfaceColor,
          boxShadow: <BoxShadow>[_containerTopShadow],
        ),
        child: TextField(
          controller: _newMessageController,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.only(left: 20),
            hintText: 'Упиши своју поруку...',
            filled: true,
            fillColor: Colors.white,
            suffixIcon: IconButton(
              icon: const Icon(Icons.send),
              color: primaryColor,
              iconSize: 25.0,
              onPressed: onMessageSend,
            ),
            enabledBorder: _inputBoxBorder,
            focusedBorder: _inputBoxBorder,
            border: _inputBoxBorder,
          ),
        ));
  }
}
