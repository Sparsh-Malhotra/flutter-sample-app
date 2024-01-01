import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:pathshala/pages/video_library/controllers/video_library_controller.dart';
import 'package:pathshala/pages/video_library/models/video_library_response.dart';
import 'package:pathshala/pages/video_library/views/video_filters.dart';
import 'package:pathshala/pages/video_library/views/video_tile.dart';
import 'package:pathshala/utils/app_colors.dart';
import 'package:pathshala/utils/curves/small_curve.dart';
import 'package:pathshala/utils/debounce.dart';
import 'package:pathshala/utils/functions.dart';

class VideoLibraryScreen extends StatefulWidget {
  const VideoLibraryScreen({super.key});

  @override
  State<VideoLibraryScreen> createState() => _VideoLibraryScreenState();
}

class _VideoLibraryScreenState extends State<VideoLibraryScreen> {
  final VideoLibraryController _videoLibraryController =
      Get.put(VideoLibraryController());

  final _debouncer = Debouncer(milliseconds: 500);

  @override
  void dispose() {
    _videoLibraryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    double topBarHeight = 135;

    return Scaffold(
      body: Stack(
        children: [
          CustomPaint(
            size: Size(width, topBarHeight),
            painter: SmallCurve(),
            child: appBar(
              'Videos',
              topBarHeight,
              trailing: VideoFiltersModal(
                onApply: (bhaag, category) {
                  _videoLibraryController.category.value = category;
                  _videoLibraryController.bhaag.value = bhaag;
                  _videoLibraryController.pagingController.refresh();
                },
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: const EdgeInsets.fromLTRB(20, 132, 20, 0),
                child: TextField(
                  controller: _videoLibraryController.searchTextController,
                  onChanged: (value) {
                    _debouncer.run(() {
                      _videoLibraryController.pagingController.refresh();
                    });
                  },
                  decoration: const InputDecoration(
                    hintText: 'Search Videos',
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColors.primary),
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: AppColors.primarySplash,
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: AppColors.primary,
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    prefixIcon: Icon(Icons.search),
                  ),
                ),
              ),
              Expanded(
                child: PagedGridView<int, Video>(
                  padding: const EdgeInsets.all(20),
                  pagingController: _videoLibraryController.pagingController,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 20,
                  ),
                  builderDelegate: PagedChildBuilderDelegate<Video>(
                    itemBuilder: (context, item, index) =>
                        VideoTile(video: item),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
