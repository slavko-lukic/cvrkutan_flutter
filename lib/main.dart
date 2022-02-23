import 'package:cvrkutan_flutter/services/pusher_service.dart';
import 'package:cvrkutan_flutter/widgets/messageFull.dart';
import 'package:cvrkutan_flutter/widgets/messageInput.dart';
import 'package:flutter/material.dart';
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';

import 'constants/colors.dart';
import 'models/message.dart';
import 'dart:convert';

void main() => runApp(const CvrkutanApp());

class CvrkutanApp extends StatefulWidget {
  const CvrkutanApp({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return CvrkutanAppState();
  }
}

class CvrkutanAppState extends State<CvrkutanApp> {
  final ScrollController _scrollController = ScrollController();

  final List<Message> messages = <Message>[];
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();

  @override
  void initState() {
    super.initState();
    initPusher();
  }

  void initPusher() {
    PusherService pusherService = PusherService(onEventHandler);
    pusherService.init();
    pusherService.subscribe('chat');
    pusherService.connect();
  }

  void onEventHandler(PusherEvent event) {
    var messageData = jsonDecode(event.data);

    Message incomingMessage = Message(
        messageData['message'],
        messageData['picture'],
        messageData['username'],
        messageData['timestamp']);

    setState(() {
      displayNewMessage(incomingMessage);
    });
  }

  void displayNewMessage(Message incomingMessage) {
    messages.add(incomingMessage);
    _listKey.currentState?.insertItem(messages.length - 1);
    _scrollDown();
  }

  void _scrollDown() {
    WidgetsBinding.instance?.addPostFrameCallback((_) =>
        {_scrollController.jumpTo(_scrollController.position.maxScrollExtent)});
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'NunitoSans',
      ),
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: primaryColor,
          title: const Text('цвркутан'),
          centerTitle: false,
          elevation: 2,
          leading: IconButton(
            icon: Image.asset('assets/images/logo-white.png'),
            onPressed: null,
          ),
        ),
        body: Stack(
          children: [
            AnimatedList(
                key: _listKey,
                controller: _scrollController,
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 120),
                initialItemCount: 0,
                itemBuilder: (BuildContext context, int index, animation) {
                  return MessageFull(
                    message: messages[index],
                    animation: animation,
                  );
                }),
            MessageInput()
          ],
        ),
      ),
    );
  }
}
