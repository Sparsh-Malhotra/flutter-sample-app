import 'package:flutter/material.dart';
import 'package:pathshala/pages/video_library/models/video_library_response.dart';
import 'package:pathshala/utils/app_colors.dart';
import 'package:pathshala/utils/app_text_styles.dart';
import 'package:pathshala/utils/functions.dart';

class VideoTile extends StatelessWidget {
  const VideoTile({super.key, required this.video});

  final Video video;

  @override
  Widget build(BuildContext context) {
    final String videoId = extractVideoId(video.url);

    return GestureDetector(
      onTap: () {
        print('Image Clicked: ${video.title}');
      },
      child: Stack(
        children: [
          Image.network(
            'https://img.youtube.com/vi/$videoId/0.jpg',
            width: 200,
            height: 130,
            fit: BoxFit.cover,
          ),
          Container(
            width: 200,
            height: 130,
            color: Colors.black.withOpacity(0.5),
          ),
          const Positioned(
            top: 10,
            bottom: 50,
            left: 50,
            right: 50,
            child: Icon(
              Icons.play_circle_outline_rounded,
              color: AppColors.white,
              size: 50,
            ),
          ),
          Positioned(
            bottom: 15,
            left: 50,
            right: 50,
            child: IgnorePointer(
              child: Text(
                video.title,
                style: AppTextStyle.boldBlack12,
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
