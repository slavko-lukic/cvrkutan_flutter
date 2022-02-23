import 'package:cvrkutan_flutter/widgets/messageFull.dart';
import 'package:flutter/material.dart';
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';

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
  static const primaryColor = Color.fromARGB(255, 0, 178, 255);
  static const surfaceColor = Color.fromARGB(255, 239, 239, 239);

  final TextEditingController _newMessageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  final List<Message> messages = <Message>[];
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();

  @override
  void initState() {
    super.initState();
    _initPusher();
  }

  void onEvent(PusherEvent event) {
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

  Future<void> _initPusher() async {
    PusherChannelsFlutter pusher = PusherChannelsFlutter.getInstance();
    try {
      await pusher.init(
        apiKey: 'd6bf8ef287243e8f9e13',
        cluster: 'eu',
        // onConnectionStateChange: onConnectionStateChange,
        // onError: onError,
        // onSubscriptionSucceeded: onSubscriptionSucceeded,
        onEvent: onEvent,
        // onSubscriptionError: onSubscriptionError,
        // onDecryptionFailure: onDecryptionFailure,
        // onMemberAdded: onMemberAdded,
        // onMemberRemoved: onMemberRemoved,
        // authEndpoint: "<Your Authendpoint>",
        // onAuthorizer: onAuthorizer
      );
      await pusher.subscribe(channelName: 'chat');
      await pusher.connect();
    } catch (e) {
      print("ERROR: $e");
    }
  }

  void _scrollDown() {
    WidgetsBinding.instance?.addPostFrameCallback((_) =>
        {_scrollController.jumpTo(_scrollController.position.maxScrollExtent)});
  }

  void onMessageSend() {
    if (_newMessageController.text == '') return;

    Message newMessage =
        Message(_newMessageController.text, ';', 'Spajk', '123');
    setState(() {
      messages.add(newMessage);
    });

    _scrollDown();

    _newMessageController.clear();
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
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                  padding: const EdgeInsets.only(
                      bottom: 30, left: 20, right: 20, top: 20),
                  decoration: const BoxDecoration(
                    color: surfaceColor,
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                          color: Colors.black45,
                          spreadRadius: 0,
                          blurRadius: 3,
                          offset: Offset(0, -1))
                    ],
                  ),
                  child:
                      Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                    // First child is enter comment text input
                    Expanded(
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
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: primaryColor, width: 1),
                            borderRadius: BorderRadius.circular(50)),
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: primaryColor, width: 1),
                            borderRadius: BorderRadius.circular(50)),
                        border: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: primaryColor, width: 1),
                            borderRadius: BorderRadius.circular(50)),
                      ),
                    )),
                    // Second child is button
                  ])),
            )
          ],
        ),
      ),
    );
  }
}
