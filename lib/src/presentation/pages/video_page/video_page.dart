import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:salen_academy/generated/l10n.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart'; // For photo access

class VideoPage extends StatefulWidget {
  static const String routeName = 'video';
  const VideoPage({super.key});

  @override
  State<VideoPage> createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  String _videoUrl =
      'https://pub-31882e13eb4a4994a7fcd18e5828bcf3.r2.dev/order_9999/slide_videos/slide_7/slide_7.m3u8';
  final List<String> _videoQueue = [];
  late WebSocketChannel _channel;
  final TextEditingController _searchController = TextEditingController();
  late String _selectedLanguage;
  late String _selectedQuality;
  int _currentIndex = 2; // VideoPage is the Tutorial tab
  bool _isSidebarOpen = false;

  @override
  void initState() {
    super.initState();
    _selectedLanguage = S.current.language;
    _selectedQuality = '1';
    _channel = WebSocketChannel.connect(
      Uri.parse('wss://your-websocket-server-url'),
    );
    _channel.stream.listen((message) {
      debugPrint("WebSocket received: $message");
      setState(() {
        _videoQueue.add(message);
      });
    });
  }

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
        }
      } else {
        debugPrint("Error: ${response.statusCode}");
      }
    } catch (e) {
      debugPrint("Exception during API call: $e");
    }
  }

  void _onTapNav(int index) {
    setState(() => _currentIndex = index);
    switch (index) {
      case 0:
        context.go('/home');
        break;
      case 1:
        context.goNamed('history');
        break;
      case 2:
        context.goNamed(VideoPage.routeName);
        break;
      case 3:
        context.goNamed('profile');
        break;
    }
  }

  // Open phone's photo gallery when paper clip is clicked
  Future<void> _openPhotoGallery() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      debugPrint("Selected photo: ${pickedFile.path}");
      // Add logic here to handle the selected photo if needed
    }
  }

  @override
  void dispose() {
    _channel.sink.close();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFF4e57f6), Color(0xFFe66465)],
            ),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.menu, color: Colors.white),
          onPressed: () {
            setState(() {
              _isSidebarOpen = !_isSidebarOpen;
            });
          },
        ),
        title: Text(
          S.current.btn_ai_tutorial_generator,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.blue, Colors.purple],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Text(
                'New Chat',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            ListTile(
              title: Text('Expression'),
              onTap: () {
                Navigator.pop(context); // Closes the drawer
              },
            ),
            ListTile(
              title: Text('Linear Equation'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('System Equation'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('New Chat'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          Center(
            // Search bar is now centered
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Container(
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Color(0xFF4e57f6), Color(0xFFe66465)],
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _searchController,
                        style: const TextStyle(color: Colors.white),
                        decoration: const InputDecoration(
                          hintText: 'Type your prompt here...',
                          hintStyle: TextStyle(color: Colors.white70),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 16, vertical: 14),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.attach_file, color: Colors.white),
                      onPressed: _openPhotoGallery, // Access phone photos
                    ),
                    IconButton(
                      icon:
                          const Icon(Icons.arrow_forward, color: Colors.white),
                      onPressed: _sendRequest,
                    ),
                  ],
                ),
              ),
            ),
          ),
          if (_isSidebarOpen)
            GestureDetector(
              onTap: () {
                setState(() {
                  _isSidebarOpen = false;
                });
              },
              child: Container(
                color: Colors.black54,
              ),
            ),
        ],
      ),
      bottomNavigationBar: Transform.translate(
        offset: const Offset(0, -10), // Adjusted to prevent overflow
        child: Container(
          height: 80,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFF4e57f6), Color(0xFFe66465)],
            ),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(4, (index) {
                final icons = [
                  Icons.home_filled,
                  Icons.play_arrow_rounded,
                  Icons.chat_rounded,
                  Icons.person_outlined
                ];
                final labels = ['Home', 'Chat', 'Tutorial', 'Profile'];
                final isActive = _currentIndex == index;
                return GestureDetector(
                  onTap: () => _onTapNav(index),
                  child: Transform.translate(
                    offset: isActive ? const Offset(0, -25) : Offset.zero,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: isActive ? 70 : 40,
                          height: isActive ? 70 : 40,
                          decoration: BoxDecoration(
                            color: isActive ? Colors.white : Colors.transparent,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            icons[index],
                            size: isActive ? 40 : 30,
                            color: isActive
                                ? Theme.of(context).primaryColor
                                : Colors.white,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          labels[index],
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: isActive ? 14 : 12,
                            fontWeight:
                                isActive ? FontWeight.bold : FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}
