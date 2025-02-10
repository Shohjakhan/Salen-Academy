import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salen_academy/src/core/date_time_formatter.dart';
import 'package:salen_academy/src/domain/video_list_cubit/video_list_cubit.dart';

class HistoryPage extends StatefulWidget {
  static const String routeName = '/history'; // Route name for navigation

  const HistoryPage({super.key});

  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<VideoListCubit>(context).getVideos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Tutorial History",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFFffa130),
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete, color: Colors.white),
            onPressed: () {},
          )
        ],
        elevation: 0.5,
      ),
      backgroundColor: Colors.grey[100],
      body: Center(
        child: BlocBuilder<VideoListCubit, VideoListState>(
          builder: (context, state) {
            if (state.isLoading) {
              return CircularProgressIndicator.adaptive();
            }
            if (state.videos.isEmpty) {
              return const Center(
                child: Text(
                  "No watch history",
                  style: TextStyle(color: Colors.black54, fontSize: 16),
                ),
              );
            }
            return ListView.builder(
              itemCount: state.videos.length,
              itemBuilder: (context, index) {
                return Card(
                  color: const Color(0xFFffa130),
                  margin:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(10),
                    title: Text(
                      state.videos[index].prompt,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      "Watched on ${state.videos[index].createdAt.format('dd.MM.yyyy hh:mm')}",
                      style: TextStyle(color: Colors.grey[100]),
                    ),
                    trailing: const Icon(Icons.more_vert, color: Colors.white),
                    onTap: () {
                      // Navigate to video page
                    },
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
