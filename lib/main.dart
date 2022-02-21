import 'package:cvrkutan_flutter/widgets/messageFull.dart';
import 'package:flutter/material.dart';

import 'models/message.dart';

void main() => runApp(CvrkutanApp());

class CvrkutanApp extends StatelessWidget {
  CvrkutanApp({Key? key}) : super(key: key);
  static const primaryColor = Color.fromARGB(255, 0, 178, 255);
  static const surfaceColor = Color.fromARGB(255, 239, 239, 239);

  final List<Message> messages = <Message>[
    const Message('Hey, what is up :)', 'spike', 'timestamp1'),
    const Message('Nothing much', 'max', 'timestamp2'),
    const Message('How are u?', 'spike', 'timestamp3'),
    const Message(
        'Also sry but i dont speak english so i dont understand what u said just now. Can u say it in some other language? Maybe espanol?',
        'spike',
        'timestamp3')
  ];

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
            ListView.builder(
                padding: const EdgeInsets.all(8),
                itemCount: messages.length,
                itemBuilder: (BuildContext context, int index) {
                  return MessageFull(message: messages[index]);
                }),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                  padding:
                      const EdgeInsets.only(bottom: 30, left: 20, right: 20),
                  decoration: const BoxDecoration(),
                  child:
                      Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                    // First child is enter comment text input
                    Expanded(
                        child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Упиши своју поруку...',
                        filled: true,
                        fillColor: surfaceColor,
                        border: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: primaryColor, width: 2),
                            borderRadius: BorderRadius.circular(50)),
                      ),
                    )),
                    // Second child is button
                    IconButton(
                      icon: const Icon(Icons.send),
                      color: primaryColor,
                      iconSize: 20.0,
                      onPressed: () {},
                    )
                  ])),
            )
          ],
        ),
      ),
    );
  }
}
