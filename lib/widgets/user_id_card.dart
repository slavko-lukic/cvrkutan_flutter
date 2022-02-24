import 'package:flutter/material.dart';

import '../constants/colors.dart';

class UserIdCard extends StatelessWidget {
  static const String _usernameLabelText = 'корисничко име';
  static const String _pictureUrlLabelText = 'урл слике';
  static const String _chatButtonText = 'Идите у Чет';

  static const Widget _usernameInputField = TextField(
    decoration: InputDecoration(
        prefixIcon: Icon(Icons.person),
        labelText: _usernameLabelText,
        filled: true,
        fillColor: Colors.transparent),
  );
  static const Widget _pictureUrlInputField = TextField(
    decoration: InputDecoration(
        prefixIcon: Icon(Icons.image),
        labelText: _pictureUrlLabelText,
        filled: true,
        fillColor: Colors.transparent),
  );

  final BoxShadow _bubbleShadow = const BoxShadow(
      color: Colors.black45,
      spreadRadius: 0,
      blurRadius: 2,
      offset: Offset(0, 0));

  const UserIdCard({Key? key}) : super(key: key);

  void navigateToChat(BuildContext context) {
    Navigator.pushNamed(context, '/chat');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.fromLTRB(50, 80, 50, 0),
        decoration: BoxDecoration(
            boxShadow: <BoxShadow>[_bubbleShadow],
            color: surfaceColor,
            borderRadius: const BorderRadius.all(Radius.circular(50))),
        width: double.infinity,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _usernameInputField,
              Container(
                margin: const EdgeInsets.only(top: 10),
                child: _pictureUrlInputField,
              ),
              Container(
                margin: const EdgeInsets.only(top: 30),
                child: ElevatedButton(
                  onPressed: () => navigateToChat(context),
                  style: ButtonStyle(
                      fixedSize: MaterialStateProperty.all<Size>(
                          const Size.fromWidth(180))),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const <Widget>[
                        Icon(Icons.chat),
                        Text(_chatButtonText)
                      ]),
                ),
              )
            ]));
  }
}
