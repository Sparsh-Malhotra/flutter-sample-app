import 'package:get/get.dart';
import 'package:pathshala/pages/resources/models/resources_response.dart';
import 'package:pathshala/services/api/resources_service.dart';
import 'package:pathshala/utils/functions.dart';

class ResourcesController extends GetxController {
  final ResourcesService _resourcesService = Get.put(ResourcesService());

  Future<List<TextResource>> getResourcesHandler() async {
    try {
      final response = await _resourcesService.getResources();
      if (response.status == 'success') {
        return response.data;
      } else {
        final errorMessage = response.error.message;
        showErrorMessage(errorMessage);
        return [];
      }
    } catch (e) {
      showErrorMessage(e.toString());
      return [];
    }
  }
}
