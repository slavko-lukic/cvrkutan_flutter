import 'package:cvrkutan_flutter/widgets/message_input.dart';
import 'package:cvrkutan_flutter/widgets/messages_container.dart';
import 'package:flutter/material.dart';

import 'constants/colors.dart';

void main() => runApp(const CvrkutanApp());

class CvrkutanApp extends StatelessWidget {
  const CvrkutanApp({Key? key}) : super(key: key);

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
        body: Column(
          children: [
            const Expanded(
              child: MessagesConainer(),
            ),
            MessageInput()
          ],
        ),
      ),
    );
  }
}
