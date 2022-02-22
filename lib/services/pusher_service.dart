import 'package:cvrkutan_flutter/constants.dart';
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';

class PusherService {
  final dynamic Function(PusherEvent) onEventHandler;
  PusherChannelsFlutter pusher = PusherChannelsFlutter.getInstance();

  PusherService(this.onEventHandler);

  Future<void> init() async {
    try {
      await pusher.init(
        apiKey: PUSHER_API_KEY,
        cluster: 'eu',
        onEvent: onEventHandler,
      );
    } catch (e) {
      print("Pusher initialization error: $e");
    }
  }

  Future<void> subscribe(String channel) async {
    try {
      await pusher.subscribe(channelName: channel);
    } catch (e) {
      print("Error while subscribing to pusher channel: $e");
    }
  }

  Future<void> connect() async {
    try {
      await pusher.connect();
    } catch (e) {
      print("Pusher connection error: $e");
    }
  }
}
