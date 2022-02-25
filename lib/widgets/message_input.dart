import 'dart:convert';

import 'package:cvrkutan_flutter/constants/api.dart';
import 'package:cvrkutan_flutter/models/message.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
    // return if input field is empty
    if (_newMessageController.text.trim() == '') {
      _newMessageController.clear();
      return;
    }

    // get user info from storage
    final prefs = await SharedPreferences.getInstance();
    String? _usernameFromStorage = prefs.getString('username');
    String? _pictureUrlFromStorage = prefs.getString('pictureUrl');

    // create message object
    Message _messageToSend = Message(
        _newMessageController.text,
        _pictureUrlFromStorage ??
            'https://cdn2.iconfinder.com/data/icons/social-flat-buttons-3/512/anonymous-512.png',
        _usernameFromStorage ?? 'anonymous',
        'timestamp');

    // clear message controller (input field)
    _newMessageController.clear();

    // make api call
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
