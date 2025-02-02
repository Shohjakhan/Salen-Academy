import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:salen_academy/generated/l10n.dart';
import 'package:video_player/video_player.dart';

class VideoPage extends StatefulWidget {
  static const String routeName = 'video';
  const VideoPage({super.key});

  @override
  State<VideoPage> createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  late VideoPlayerController _controller;

  // For the user prompt
  final TextEditingController _searchController = TextEditingController();

  // For the user’s chosen preferences
  String _selectedLanguage = 'en'; // 'uz', 'ru', 'en'
  String _selectedQuality = '3'; // '1', '2', '3'

  @override
  void initState() {
    super.initState();
    // Initialize with some default video
    _controller = VideoPlayerController.networkUrl(
      Uri.parse(
          'https://fe5d-195-158-11-141.ngrok-free.app//static/final_videos/ChainRule.mp4'),
    )..initialize().then((_) {
        setState(() {});
      });
  }

  // Show a dialog in the middle of the screen for choosing language and quality
  Future<void> _showPreferencesDialog() async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        // We’ll use AlertDialog so it appears in the center
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: Text('Choose Preferences'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Language block
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
                // Quality block
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
                Navigator.of(context).pop(); // close the dialog
              },
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFffa130),
              ),
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
                // After preferences chosen, proceed to send request
                _sendRequest();
              },
            ),
          ],
        );
      },
    );
  }

  // This method will make the POST request to your API
  Future<void> _sendRequest() async {
    // Replace with your actual API URL
    const String apiUrl =
        "https://fe5d-195-158-11-141.ngrok-free.app//generate_video";

    final Map<String, dynamic> body = {
      "language": _selectedLanguage, // "uz", "ru", or "en"
      "prompt": _searchController.text, // from the search bar
      "quality": _selectedQuality, // "1", "2", or "3"
      "id": 8 // default value of 8
    };

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        // Parse the returned JSON, e.g. { "video_link": "http://..." }
        final decoded = jsonDecode(response.body);
        final String newVideoUrl = decoded['video_link'] ?? '';

        if (newVideoUrl.isNotEmpty) {
          // Re-initialize the video player with the new URL
          setState(() {
            _controller.pause();
            _controller.dispose();

            _controller = VideoPlayerController.networkUrl(
              Uri.parse(newVideoUrl),
            )..initialize().then((_) {
                setState(() {
                  // once the new video is initialized, rebuild
                });
              });
          });
        }
      } else {
        debugPrint("Error: ${response.statusCode}");
      }
    } catch (e) {
      debugPrint("Exception during API call: $e");
    }
  }

  // Skip backward 5 seconds
  void _skipBackward() {
    final currentPosition = _controller.value.position;
    Duration newPosition = currentPosition - const Duration(seconds: 5);
    if (newPosition < Duration.zero) {
      newPosition = Duration.zero;
    }
    _controller.seekTo(newPosition);
  }

  // Skip forward 5 seconds
  void _skipForward() {
    final currentPosition = _controller.value.position;
    final maxPosition = _controller.value.duration;
    Duration newPosition = currentPosition + const Duration(seconds: 5);
    if (newPosition > maxPosition) {
      newPosition = maxPosition;
    }
    _controller.seekTo(newPosition);
  }

  @override
  void dispose() {
    _controller.dispose();
    _searchController.dispose();
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
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20),
          ),
        ),
      ),
      body: Column(
        children: [
          // Video player
          AspectRatio(
            aspectRatio: _controller.value.isInitialized
                ? _controller.value.aspectRatio
                : 16 / 9,
            child: VideoPlayer(_controller),
          ),

          // Playback controls (three icon buttons in a row)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.replay_5),
                onPressed: () => setState(() => _skipBackward()),
              ),
              IconButton(
                icon: Icon(
                  _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
                ),
                onPressed: () {
                  setState(() {
                    _controller.value.isPlaying
                        ? _controller.pause()
                        : _controller.play();
                  });
                },
              ),
              IconButton(
                icon: const Icon(Icons.forward_5),
                onPressed: () => setState(() => _skipForward()),
              ),
            ],
          ),

          const Spacer(),
          // Container with the search bar and button
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
                    onPressed: () {
                      // When user clicks send, open the preferences dialog
                      // Then the dialog’s OK button will call _sendRequest()
                      _showPreferencesDialog();
                    },
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
    );
  }
}
