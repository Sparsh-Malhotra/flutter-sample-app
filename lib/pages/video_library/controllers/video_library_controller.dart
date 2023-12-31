import 'package:get/get.dart';
import 'package:pathshala/pages/video_library/models/video_library_response.dart';
import 'package:pathshala/services/api/resources_service.dart';
import 'package:pathshala/utils/functions.dart';

class VideoLibraryController extends GetxController {
  final ResourcesService _resourcesService = Get.put(ResourcesService());
  RxnString category = RxnString(null);
  RxnString bhaag = RxnString(null);

  Future<VideoInfo> getVideosHandler(Map<dynamic, String> params) async {
    try {
      final response = await _resourcesService.getVideos(
        {"page": 1, 'category': category.value, ...params},
      );
      if (response.status == 'success') {
        return response.data;
      } else {
        final errorMessage = response.error.message;
        showErrorMessage(errorMessage);
        return VideoInfo(count: 0, results: []);
      }
    } catch (e) {
      showErrorMessage(e.toString());
      return VideoInfo(count: 0, results: []);
    }
  }
}
