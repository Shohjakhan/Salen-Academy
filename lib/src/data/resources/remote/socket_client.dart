import 'package:socket_io_client/socket_io_client.dart';

import '../../../core/logger.dart';

abstract class SocketClient {
  static Socket? _socket;

  static Future<void> _initialize(String url) async {
    if (_socket != null && _socket!.connected) return;

    try {
      _socket = io(
        url,
        OptionBuilder()
            .setTransports(['websocket'])
            .enableForceNewConnection()
            .build(),
      );

      _socket!.connect();
      _socket!.onConnect((data) => logger.d('Connecting...'));
      _socket!.onDisconnect((data) => logger.d('Disconnected'));
      _socket!.on('connect', (data) => logger.d('Connected to ${_socket!}'));
    } catch (e) {
      logger.e(e.toString());
    }
  }

  static Future<Socket> init(String url) async {
    await _initialize(url);
    await Future.delayed(const Duration(milliseconds: 500));

    return _socket!;
  }

  static disconnect() {
    if (_socket != null) _socket!.dispose();
  }

  static Socket get socket {
    if (_socket != null) return _socket!;

    throw Exception('Socket not implemented');
  }
}
