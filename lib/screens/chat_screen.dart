import 'package:flutter/material.dart';

import '../widgets/message_input.dart';
import '../widgets/messages_container.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  get primaryColor => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: const Text('цвркутан'),
        centerTitle: false,
        elevation: 2,
        leading: IconButton(
          icon: Image.asset('assets/images/logo-white.png'),
          onPressed: null,
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.person))
        ],
      ),
      body: Column(
        children: [
          const Expanded(
            child: MessagesConainer(),
          ),
          MessageInput()
        ],
      ),
    );
  }
}
