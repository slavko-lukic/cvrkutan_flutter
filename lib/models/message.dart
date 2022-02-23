class Message {
  final String message;
  final String username;
  final String picture;
  final String timestamp;

  const Message(this.message, this.picture, this.username, this.timestamp);

  Map toJson() =>
      {'message': message, 'username': username, 'picture': picture};
}
