import 'dart:io';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pathshala/utils/functions.dart';

class BookController extends GetxController {
  final RxDouble progress = RxDouble(0);
  final RxBool isDownloading = false.obs;

  Future<void> downloadBookHandler(String filename, String url) async {
    try {
      isDownloading.value = true;
      final response = await Dio().get<List<int>>(
        url,
        onReceiveProgress: (count, total) => progress.value = count * 100,
        options: Options(
          responseType: ResponseType.bytes,
        ),
      );

      if (response.statusCode == 200) {
        final directory = Platform.isIOS
            ? await getApplicationDocumentsDirectory()
            : await getExternalStorageDirectory();
        final filePath = '${directory?.path}/books/$filename.pdf';

        // Save the downloaded content to a file in the documents directory
        await File(filePath).writeAsBytes(response.data as List<int>);
        isDownloading.value = false;
        await OpenFile.open(filePath, type: 'application/pdf');
      } else {
        isDownloading.value = false;
        showErrorMessage('Failed to download the book.');
      }
    } catch (e) {
      isDownloading.value = false;
      showErrorMessage('Error: $e');
    }
  }

  Future<bool> isBookDownloaded(String filename) async {
    // Get the app's documents directory
    final directory = Platform.isIOS
        ? await getApplicationDocumentsDirectory()
        : await getExternalStorageDirectory();
    final filePath = '${directory?.path}/books/$filename.pdf';

    // Check if the file exists
    return File(filePath).exists();
  }
}
