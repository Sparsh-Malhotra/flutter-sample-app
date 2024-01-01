import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pathshala/pages/video_library/models/video_library_response.dart';
import 'package:pathshala/utils/app_colors.dart';
import 'package:pathshala/utils/app_text_styles.dart';
import 'package:pathshala/utils/functions.dart';
import 'package:pathshala/widgets/resources/video_player/video_player.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart' hide Video;

class VideoTile extends StatefulWidget {
  const VideoTile({Key? key, required this.video}) : super(key: key);

  final Video video;

  @override
  State<VideoTile> createState() {
    return VideoTileState();
  }
}

class VideoTileState extends State<VideoTile> {
  final yt = YoutubeExplode();

  late String videoId;

  @override
  void initState() {
    super.initState();
    videoId = extractVideoId(widget.video.url);
  }

  @override
  void dispose() {
    yt.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final manifest = await yt.videos.streamsClient.getManifest(videoId);
        Get.to(
          () => VideoPlayer(
            manifest: manifest,
          ),
        );
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
                widget.video.title,
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
