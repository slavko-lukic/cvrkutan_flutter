import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/colors.dart';

class UserIdCard extends StatefulWidget {
  const UserIdCard({Key? key}) : super(key: key);

  @override
  State<UserIdCard> createState() => _UserIdCardState();
}

class _UserIdCardState extends State<UserIdCard> {
  static const String _usernameLabelText = 'корисничко име';
  static const String _pictureUrlLabelText = 'урл слике';
  static const String _chatButtonText = 'Идите у Чет';

  static const InputDecoration _usernameInputFieldDecoration = InputDecoration(
      prefixIcon: Icon(Icons.person),
      labelText: _usernameLabelText,
      filled: true,
      fillColor: Colors.transparent);
  static const InputDecoration _pictureInputFieldDecoration = InputDecoration(
      prefixIcon: Icon(Icons.image),
      labelText: _pictureUrlLabelText,
      filled: true,
      fillColor: Colors.transparent);

  static const BoxShadow _bubbleShadow = BoxShadow(
      color: Colors.black45,
      spreadRadius: 0,
      blurRadius: 2,
      offset: Offset(0, 0));

  static const BorderRadiusGeometry _cardBorderRadius = BorderRadius.only(
      topLeft: Radius.circular(50), topRight: Radius.circular(50));

  final TextEditingController _usernameInputController =
      TextEditingController();
  final TextEditingController _pictureInputController = TextEditingController();

  bool _usernameInputIsValid = false;
  bool _pictureInputIsValid = false;

  @override
  void initState() {
    super.initState();

    _getUserData();
  }

  Future<void> navigateToChat(BuildContext context) async {
    bool _invalidInputs = _usernameInputController.text.trim() == '' ||
        _pictureInputController.text.trim() == '';

    if (_invalidInputs) return;

    await _updateUserData();

    Navigator.pushNamed(context, '/chat');
  }

  Future<void> _getUserData() async {
    final prefs = await SharedPreferences.getInstance();

    String? _usernameFromStorage = prefs.getString('username');
    String? _pictureUrlFromStorage = prefs.getString('pictureUrl');

    WidgetsBinding.instance?.addPostFrameCallback((_) {
      setState(() {
        if (_usernameFromStorage != null && _usernameFromStorage != '') {
          _usernameInputController.text = _usernameFromStorage;
          _usernameInputIsValid = true;
        }

        if (_pictureUrlFromStorage != null && _pictureUrlFromStorage != '') {
          _pictureInputController.text = _pictureUrlFromStorage;
          _pictureInputIsValid = true;
        }
      });
    });
  }

  Future<void> _updateUserData() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString('username', _usernameInputController.text);
    await prefs.setString('pictureUrl', _pictureInputController.text);
  }

  void _usernameInputOnChangedHandler(String value) {
    if (value == '') {
      setState(() {
        _usernameInputIsValid = false;
      });
    } else {
      setState(() {
        _usernameInputIsValid = true;
      });
    }
  }

  void _pictureUrlInputOnChangedHandler(String value) {
    if (value == '') {
      setState(() {
        _pictureInputIsValid = false;
      });
    } else {
      setState(() {
        _pictureInputIsValid = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.fromLTRB(50, 80, 50, 0),
        decoration: const BoxDecoration(
            boxShadow: <BoxShadow>[_bubbleShadow],
            color: surfaceColor,
            borderRadius: _cardBorderRadius),
        width: double.infinity,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextField(
                onChanged: (value) => _usernameInputOnChangedHandler(value),
                controller: _usernameInputController,
                decoration: _usernameInputFieldDecoration,
              ),
              Container(
                margin: const EdgeInsets.only(top: 10),
                child: TextField(
                  onChanged: (value) => _pictureUrlInputOnChangedHandler(value),
                  controller: _pictureInputController,
                  decoration: _pictureInputFieldDecoration,
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 30),
                child: ElevatedButton(
                  onPressed: _usernameInputIsValid && _pictureInputIsValid
                      ? () => navigateToChat(context)
                      : null,
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
