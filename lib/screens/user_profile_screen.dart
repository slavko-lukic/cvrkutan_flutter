import 'package:flutter/material.dart';

import '../widgets/logo_and_label.dart';
import '../widgets/user_id_card.dart';

class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(children: const [
        Expanded(
          flex: 2,
          child: LogoAndLabel(),
        ),
        Expanded(
          flex: 4,
          child: UserIdCard(),
        ),
      ]),
    );
  }
}
