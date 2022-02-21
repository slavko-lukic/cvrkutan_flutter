import 'package:flutter/material.dart';

class MessageUserData extends StatelessWidget {
  final String username;
  const MessageUserData({required this.username, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(3),
            margin: const EdgeInsets.only(bottom: 5), // Border width
            decoration: const BoxDecoration(boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Colors.black,
                  blurRadius: 3.0,
                  offset: Offset(0.0, 0.75))
            ], color: Colors.white, shape: BoxShape.circle),
            child: ClipOval(
              child: SizedBox.fromSize(
                size: const Size.fromRadius(20), // Image radius
                child: Image.network('https://i.redd.it/duclb7qrpn771.jpg',
                    fit: BoxFit.cover),
              ),
            ),
          ),
          Text(
            '@' + username,
            overflow: TextOverflow.ellipsis,
          )
        ],
      ),
    );
  }
}
