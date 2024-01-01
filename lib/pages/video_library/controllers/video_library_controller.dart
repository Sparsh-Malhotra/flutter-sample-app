import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:pathshala/pages/video_library/models/video_library_response.dart';
import 'package:pathshala/services/api/resources_service.dart';
import 'package:pathshala/utils/functions.dart';

class VideoLibraryController extends GetxController {
  static const _pageSize = 10;
  final PagingController<int, Video> pagingController =
      PagingController(firstPageKey: 1);

  final ResourcesService _resourcesService = Get.put(ResourcesService());
  RxnString category = RxnString(null);
  RxnString bhaag = RxnString(null);
  final searchTextController = TextEditingController();
  bool isControllerDisposed = false;

  @override
  void onInit() {
    pagingController.addPageRequestListener((pageKey) {
      if (!isControllerDisposed) {
        getVideosHandler({}, pageKey);
      }
    });
    super.onInit();
  }

  @override
  void onClose() {
    searchTextController.dispose();
    pagingController.dispose();
    isControllerDisposed = true;
    super.onClose();
  }

  Future<void> getVideosHandler(Map<dynamic, String> params,
      [int? pageKey]) async {
    try {
      final response = await _resourcesService.getVideos(
        {
          "page": pageKey ?? 1,
          'category': category.value,
          'bhaag_id': bhaag.value,
          'search': searchTextController.text
        },
      );
      if (response.status == 'success') {
        final isLastPage = response.data.count ==
            (((pageKey ?? 1) - 1) * _pageSize) + response.data.results.length;
        if (isLastPage) {
          pagingController.appendLastPage(response.data.results);
        } else {
          pagingController.appendPage(
              response.data.results, pageKey != null ? pageKey + 1 : 2);
        }
        // return response.data;
      } else {
        final errorMessage = response.error.message;
        showErrorMessage(errorMessage);
        pagingController.error = errorMessage;
        // return VideoInfo(count: 0, results: []);
      }
    } catch (e) {
      showErrorMessage(e.toString());
      pagingController.error = e.toString();
      // return VideoInfo(count: 0, results: []);
    }
  }
}
