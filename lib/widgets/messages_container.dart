import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';

import '../models/message.dart';
import '../services/pusher_service.dart';
import 'message_block.dart';

class MessagesConainer extends StatefulWidget {
  const MessagesConainer({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return MessagesContainerState();
  }
}

class MessagesContainerState extends State<MessagesConainer> {
  final List<Message> _messages = <Message>[];

  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();

  final ScrollController _scrollController = ScrollController();

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
    _messages.add(incomingMessage);
    _listKey.currentState?.insertItem(_messages.length - 1);
    _scrollDown();
  }

  void _scrollDown() {
    // called after ui is rendered
    WidgetsBinding.instance?.addPostFrameCallback((_) =>
        {_scrollController.jumpTo(_scrollController.position.maxScrollExtent)});
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedList(
        key: _listKey,
        controller: _scrollController,
        padding: const EdgeInsets.only(bottom: 20),
        initialItemCount: 0,
        itemBuilder: (BuildContext context, int index, animation) {
          return MessageBlock(
            message: _messages[index],
            animation: animation,
          );
        });
  }
}
