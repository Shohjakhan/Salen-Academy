import 'package:flutter/material.dart';

class HistoryPage extends StatefulWidget {
  static const String routeName = '/history'; // Route name for navigation

  const HistoryPage({super.key});

  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  List<Map<String, String>> videoHistory = [
    {
      "title": "Introduction to AI",
      "thumbnail":
          "/Users/gulistonpm/Projects/salen_academy/assets/images/images.jpeg",
      "date": "Jan 25, 2025"
    },
    {
      "title": "Building Apps with Flutter",
      "thumbnail":
          "/Users/gulistonpm/Projects/salen_academy/assets/images/flutter-igmguru_1527424732_l.jpg",
      "date": "Jan 24, 2025"
    },
    {
      "title": "Understanding Economics",
      "thumbnail":
          "/Users/gulistonpm/Projects/salen_academy/assets/images/Pros-and-Cons-of-Studying-Economics.jpg",
      "date": "Jan 23, 2025"
    },
  ];

  void _clearHistory() {
    setState(() {
      videoHistory.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Watch History",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete, color: Colors.black),
            onPressed: () {
              _clearHistory();
            },
          )
        ],
        elevation: 0.5,
      ),
      backgroundColor: Colors.grey[100],
      body: videoHistory.isEmpty
          ? const Center(
              child: Text(
                "No watch history",
                style: TextStyle(color: Colors.black54, fontSize: 16),
              ),
            )
          : ListView.builder(
              itemCount: videoHistory.length,
              itemBuilder: (context, index) {
                return Card(
                  color: Colors.white,
                  margin:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(10),
                    leading: SizedBox(
                      width:
                          80, // Prevents leading widget from consuming full width
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          videoHistory[index]["thumbnail"]!,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    title: Text(
                      videoHistory[index]["title"]!,
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      "Watched on ${videoHistory[index]["date"]}",
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                    trailing: const Icon(Icons.more_vert, color: Colors.black),
                    onTap: () {
                      // Navigate to video page
                    },
                  ),
                );
              },
            ),
    );
  }
}
