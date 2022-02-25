import 'package:cvrkutan_flutter/screens/chat_screen.dart';
import 'package:cvrkutan_flutter/screens/user_profile_screen.dart';
import 'package:flutter/material.dart';

void main() => runApp(const CvrkutanApp());

class CvrkutanApp extends StatelessWidget {
  const CvrkutanApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'NunitoSans',
      ),
      home: const UserProfileScreen(),
      routes: {
        '/user': (context) => const UserProfileScreen(),
        '/chat': (context) => const ChatScreen()
      },
    );
  }
}
