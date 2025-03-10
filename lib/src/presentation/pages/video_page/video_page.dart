import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:salen_academy/generated/l10n.dart';
import 'package:better_player/better_player.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class VideoPage extends StatefulWidget {
  static const String routeName = 'video';
  const VideoPage({super.key});

  @override
  State<VideoPage> createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  // Current video URL (initial URL) that will be updated when new video links arrive.
  String _videoUrl =
      'https://pub-31882e13eb4a4994a7fcd18e5828bcf3.r2.dev/order_9999/slide_videos/slide_7/slide_7.m3u8';

  // Queue to store video links (slides) received from WebSocket or manually added.
  final List<String> _videoQueue = [];

  // WebSocket channel variable.
  late WebSocketChannel _channel;

  // BetterPlayer controller.
  late BetterPlayerController _betterPlayerController;

  // Controllers and variables for user input.
  final TextEditingController _searchController = TextEditingController();
  late String _selectedLanguage; // e.g. 'uz', 'ru', 'en'
  late String _selectedQuality; // e.g. '1', '2', '3'

  @override
  void initState() {
    super.initState();
    _selectedLanguage = S.current.language;
    _selectedQuality = '1'; // Default quality.

    // Initialize BetterPlayer with the initial video URL.
    _initializeBetterPlayer(_videoUrl);

    // Establish the WebSocket connection.
    _channel = WebSocketChannel.connect(
      Uri.parse(
          'wss://your-websocket-server-url'), // Replace with your actual WebSocket URL.
    );

    // Listen to incoming WebSocket messages.
    _channel.stream.listen((message) {
      debugPrint("WebSocket received: $message");
      setState(() {
        // Add each received video link to the queue.
        _videoQueue.add(message);
      });
    });
  }

  // Initialize BetterPlayerController with the given URL.
  void _initializeBetterPlayer(String url) {
    BetterPlayerDataSource dataSource = BetterPlayerDataSource(
      BetterPlayerDataSourceType.network,
      url,
      liveStream: true,
    );

    BetterPlayerConfiguration configuration = BetterPlayerConfiguration(
      aspectRatio: 16 / 9,
      autoPlay: true,
      eventListener: (BetterPlayerEvent event) {
        // When the video finishes, trigger the callback.
        if (event.betterPlayerEventType == BetterPlayerEventType.finished) {
          _onVideoEnd();
        }
      },
    );

    _betterPlayerController = BetterPlayerController(
      configuration,
      betterPlayerDataSource: dataSource,
    );
  }

  // Called when the current video finishes playing.
  void _onVideoEnd() {
    if (_videoQueue.isNotEmpty) {
      String nextUrl = _videoQueue.removeAt(0);
      setState(() {
        _videoUrl = nextUrl;
      });
      // Update the BetterPlayer data source to the new URL.
      BetterPlayerDataSource newDataSource = BetterPlayerDataSource(
        BetterPlayerDataSourceType.network,
        _videoUrl,
        liveStream: true,
      );
      _betterPlayerController.setupDataSource(newDataSource);
    } else {
      debugPrint("No more video links in the queue.");
    }
  }

  // Show a dialog for selecting language and quality.
  Future<void> _showPreferencesDialog() async {
    return await showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: Text('Choose Preferences'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Language selection.
                ExpansionTile(
                  title: Text('Language'),
                  children: [
                    RadioListTile<String>(
                      title: Text('Uzbek'),
                      value: 'uz',
                      groupValue: _selectedLanguage,
                      onChanged: (value) {
                        setState(() {
                          _selectedLanguage = value ?? 'uz';
                        });
                      },
                    ),
                    RadioListTile<String>(
                      title: Text('Russian'),
                      value: 'ru',
                      groupValue: _selectedLanguage,
                      onChanged: (value) {
                        setState(() {
                          _selectedLanguage = value ?? 'ru';
                        });
                      },
                    ),
                    RadioListTile<String>(
                      title: Text('English'),
                      value: 'en',
                      groupValue: _selectedLanguage,
                      onChanged: (value) {
                        setState(() {
                          _selectedLanguage = value ?? 'en';
                        });
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                // Quality selection.
                ExpansionTile(
                  title: Text('Quality'),
                  children: [
                    RadioListTile<String>(
                      title: Text('High'),
                      value: '1',
                      groupValue: _selectedQuality,
                      onChanged: (value) {
                        setState(() {
                          _selectedQuality = value ?? '1';
                        });
                      },
                    ),
                    RadioListTile<String>(
                      title: Text('Medium'),
                      value: '2',
                      groupValue: _selectedQuality,
                      onChanged: (value) {
                        setState(() {
                          _selectedQuality = value ?? '2';
                        });
                      },
                    ),
                    RadioListTile<String>(
                      title: Text('Low'),
                      value: '3',
                      groupValue: _selectedQuality,
                      onChanged: (value) {
                        setState(() {
                          _selectedQuality = value ?? '3';
                        });
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel', style: TextStyle(color: Colors.grey)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFffa130)),
              child: Text('OK'),
              onPressed: () {
                _sendRequest();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  // Sends a POST request to your API.
  Future<void> _sendRequest() async {
    const String apiUrl =
        "https://fe5d-195-158-11-141.ngrok-free.app//generate_video";
    final Map<String, dynamic> body = {
      "language": _selectedLanguage,
      "prompt": _searchController.text,
      "quality": _selectedQuality,
      "id": 8
    };
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(body),
      );
      if (response.statusCode == 200) {
        final decoded = jsonDecode(response.body);
        final String newVideoUrl = decoded['video_link'] ?? '';
        if (newVideoUrl.isNotEmpty) {
          setState(() {
            _videoUrl = newVideoUrl;
          });
          BetterPlayerDataSource newDataSource = BetterPlayerDataSource(
            BetterPlayerDataSourceType.network,
            _videoUrl,
            liveStream: true,
          );
          _betterPlayerController.setupDataSource(newDataSource);
        }
      } else {
        debugPrint("Error: ${response.statusCode}");
      }
    } catch (e) {
      debugPrint("Exception during API call: $e");
    }
  }

  @override
  void dispose() {
    _channel.sink.close();
    _searchController.dispose();
    _betterPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFffa130),
        title: Text(
          S.current.btn_ai_tutorial_generator,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            letterSpacing: 1.2,
          ),
        ),
        centerTitle: true,
        elevation: 8,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
        ),
      ),
      body: Column(
        children: [
          // BetterPlayer widget for HLS streaming.
          AspectRatio(
            aspectRatio: 16 / 9,
            child: BetterPlayer(
              controller: _betterPlayerController,
            ),
          ),
          // Optional playback controls.
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.replay_5),
                onPressed: () {
                  // Add custom logic for replay if needed.
                },
              ),
              IconButton(
                icon: const Icon(Icons.pause),
                onPressed: () {
                  // Add custom logic for pause if needed.
                },
              ),
              IconButton(
                icon: const Icon(Icons.forward_5),
                onPressed: () {
                  // Add custom logic for forward if needed.
                },
              ),
            ],
          ),
          const Spacer(),
          // Search bar and send button container.
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
              color: const Color(0xFFffa130),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, -5),
                ),
              ],
            ),
            child: SafeArea(
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            blurRadius: 15,
                            spreadRadius: 2,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Icon(Icons.search, color: Colors.grey),
                          ),
                          Expanded(
                            child: TextField(
                              controller: _searchController,
                              decoration: InputDecoration(
                                hintText: S.current.hint_generate_tutorials,
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: _showPreferencesDialog,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: const CircleBorder(),
                      padding: const EdgeInsets.all(10),
                      shadowColor: Colors.grey.withOpacity(0.3),
                      elevation: 10,
                    ),
                    child: const Icon(Icons.arrow_forward,
                        color: Color(0xFFffa130)),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      // Floating Action Button to manually add test URLs to the queue.
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFFffa130),
        child: const Icon(Icons.add),
        onPressed: () {
          setState(() {
            // Manually add several test URLs.
            _videoQueue.add(
                "https://pub-31882e13eb4a4994a7fcd18e5828bcf3.r2.dev/order_9999/slide_videos/slide_6/slide_6.m3u8");
            _videoQueue.add(
                "https://pub-31882e13eb4a4994a7fcd18e5828bcf3.r2.dev/order_9999/slide_videos/slide_7/slide_7.m3u8");
            _videoQueue.add(
                "hhttps://pub-31882e13eb4a4994a7fcd18e5828bcf3.r2.dev/order_9999/slide_videos/slide_7/slide_7.m3u8");
            _videoQueue.add(
                "https://pub-31882e13eb4a4994a7fcd18e5828bcf3.r2.dev/order_9999/slide_videos/slide_9/slide_9.m3u8");
            _videoQueue.add(
                "https://pub-31882e13eb4a4994a7fcd18e5828bcf3.r2.dev/order_9999/slide_videos/slide_10/slide_10.m3u8");
            _videoQueue.add(
                "https://pub-31882e13eb4a4994a7fcd18e5828bcf3.r2.dev/order_9999/slide_videos/slide_10/slide_11.m3u8");
          });
          debugPrint("Test URLs added to queue: $_videoQueue");
        },
      ),
    );
  }
}
