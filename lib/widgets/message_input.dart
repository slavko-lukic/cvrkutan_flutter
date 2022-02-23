import 'dart:convert';

import 'package:cvrkutan_flutter/constants/api.dart';
import 'package:cvrkutan_flutter/models/message.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

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

  void onMessageSend() async {
    if (_newMessageController.text.trim() == '') {
      _newMessageController.clear();
      return;
    }

    Message _messageToSend = Message(
        _newMessageController.text,
        'https://imagesvc.meredithcorp.io/v3/mm/image?url=https%3A%2F%2Fstatic.onecms.io%2Fwp-content%2Fuploads%2Fsites%2F6%2F2019%2F09%2Fross-friends-pivot-2000.jpg',
        'dr_geller',
        'timestamp');

    _newMessageController.clear();

    try {
      await post(Uri.parse(baseUrl + messagesUrl),
          body: jsonEncode(_messageToSend.toJson()),
          headers: {
            "Accept": "application/json",
            "content-type": "application/json"
          });
    } catch (e) {
      print("Error while sending message: $e");
    }
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
