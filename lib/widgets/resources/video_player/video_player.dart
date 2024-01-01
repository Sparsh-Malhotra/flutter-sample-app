import 'package:com.jainyouthnoida.pathshala/widgets/resources/video_player/video_player_controls.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart' hide Video;

class VideoPlayer extends StatefulWidget {
  const VideoPlayer({super.key, required this.manifest});

  final StreamManifest manifest;

  @override
  State<VideoPlayer> createState() => _VideoPlayerState();
}

class _VideoPlayerState extends State<VideoPlayer> {
  late FlickManager _flickManager;

  @override
  void initState() {
    super.initState();
    _flickManager = FlickManager(
      videoPlayerController: VideoPlayerController.networkUrl(
        widget.manifest.muxed.withHighestBitrate().url,
      ),
    );
  }

  @override
  void dispose() {
    _flickManager.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FlickVideoPlayer(
        flickManager: _flickManager,
        preferredDeviceOrientation: const [
          DeviceOrientation.landscapeRight,
          DeviceOrientation.landscapeLeft
        ],
        systemUIOverlay: const [],
        flickVideoWithControls: const FlickVideoWithControls(
          controls: VideoPlayerControls(),
        ),
      ),
    );
  }
}
