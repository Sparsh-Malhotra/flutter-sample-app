import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pathshala/pages/video_library/controllers/video_library_controller.dart';
import 'package:pathshala/pages/video_library/views/video_tile.dart';
import 'package:pathshala/utils/app_colors.dart';
import 'package:pathshala/utils/curves/small_curve.dart';
import 'package:pathshala/utils/functions.dart';

class VideoLibraryScreen extends StatefulWidget {
  const VideoLibraryScreen({super.key});

  @override
  State<VideoLibraryScreen> createState() => _VideoLibraryScreenState();
}

class _VideoLibraryScreenState extends State<VideoLibraryScreen> {
  final VideoLibraryController _videoLibraryController =
      Get.put(VideoLibraryController());

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    double topBarHeight = 135;

    return Scaffold(
      body: FutureBuilder(
        future: _videoLibraryController.getVideosHandler(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                color: AppColors.primary,
              ),
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: Text('No videos found'),
            );
          } else if (snapshot.hasData) {
            return Stack(
              children: [
                SizedBox(
                  height: height,
                  width: width,
                  child: GridView.count(
                    padding: const EdgeInsets.only(
                        left: 20, right: 20, top: 132, bottom: 20),
                    crossAxisCount: 2,
                    crossAxisSpacing: 20,
                    children: List.generate(
                      snapshot.data!.results.length,
                      (index) =>
                          VideoTile(video: snapshot.data!.results[index]),
                    ),
                  ),
                ),
                CustomPaint(
                  size: Size(width, topBarHeight),
                  painter: SmallCurve(),
                  child: appBar(
                    'Videos',
                    topBarHeight,
                  ),
                ),
              ],
            );
          } else {
            return const Center(
              child: Text('No books found'),
            ); // Initial state
          }
        },
      ),
    );
  }
}
