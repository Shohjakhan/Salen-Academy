import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:salen_academy/generated/l10n.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:image_picker/image_picker.dart'; // For photo access

class VideoPage extends StatefulWidget {
  static const String routeName = 'video';
  const VideoPage({super.key});

  @override
  State<VideoPage> createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  late WebSocketChannel _channel;
  final TextEditingController _searchController = TextEditingController();
  late String _selectedLanguage;
  late String _selectedQuality;
  bool _isSidebarOpen = false;

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
          setState(() {});
        }
      } else {
        debugPrint("Error: ${response.statusCode}");
      }
    } catch (e) {
      debugPrint("Exception during API call: $e");
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
          S.current.title_generator,
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
                S.current.btn_new_chat,
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
                        decoration: InputDecoration(
                          hintText: S.current.field_promt,
                          hintStyle: const TextStyle(color: Colors.white70),
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(
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
    );
  }
}
