import 'package:flutter/material.dart';

class MessageUserInfo extends StatelessWidget {
  final String username;

  final String picture;

  final BoxShadow _circleShadow = const BoxShadow(
      color: Colors.black, blurRadius: 3.0, offset: Offset(0.0, 0.75));

  const MessageUserInfo(
      {required this.username, required this.picture, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(3),
            margin: const EdgeInsets.only(bottom: 5), // Border width
            decoration: BoxDecoration(
                boxShadow: <BoxShadow>[_circleShadow],
                color: Colors.white,
                shape: BoxShape.circle),
            child: ClipOval(
              child: SizedBox.fromSize(
                size: const Size.fromRadius(20), // Image radius
                child: Image.network(picture, fit: BoxFit.cover),
              ),
            ),
          ),
          Text(
            '@' + username,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 12, color: Colors.black),
          )
        ],
      ),
    );
  }
}
