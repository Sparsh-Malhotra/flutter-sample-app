import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pathshala/utils/functions.dart';
import 'package:pathshala/services/api/resources_service.dart';
import 'package:pathshala/pages/resources/models/resources_response.dart';

class ResourceController extends GetxController {

    Future<String?> getTextResourcesHandler(id) async {
      final ResourcesService _resourcesService = Get.put(ResourcesService());

      try {
        final response = await _resourcesService.getTextResource(id); //#TODD DYANMIC

        if (response.status == 'success') {

          return response.data[0].text!.replaceAll('\\n', '\n');
        } else {
          final errorMessage = response.error.message;
          showErrorMessage(errorMessage);
          return null;
        }
      } catch (e) {
        showErrorMessage(e.toString());
        return null;
      }
    }
}
