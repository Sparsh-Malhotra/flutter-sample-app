import 'package:pathshala/app_contants.dart';
import 'package:pathshala/utils/app_text_styles.dart';
import 'package:pathshala/utils/app_colors.dart';
import 'package:pathshala/widgets/cards/topbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

Widget appBar(String title, double height, {Widget? trailing}) {
  return TopBar(
    height: height,
    width: double.infinity,
    leading: GestureDetector(
      onTap: () => Get.back(),
      child: const Icon(
        Icons.arrow_back,
        color: AppColors.white,
        size: 26,
      ),
    ),
    title: Text(
      title,
      style: AppTextStyle.regularBlack18.copyWith(color: AppColors.white),
    ),
    trailing: trailing,
  );
}

// Global snackBar can be used directly anywhere in the app
snackBar(String title, String description, {IconData? icon}) {
  return Get.snackbar(
    title,
    description,
    icon: Icon(
      icon ?? Icons.warning,
      color: AppColors.white,
    ),
    backgroundColor: AppColors.secondary.withOpacity(0.6),
    colorText: AppColors.white,
  );
}

formatDate(String? date) {
  DateFormat format = DateFormat.yMMMd();
  DateTime dateTime = DateTime.parse(date!);
  String formattedDate = format.format(dateTime);
  return formattedDate;
}

void showErrorMessage(String message) {
  Get.snackbar(
    'Error',
    message,
    snackPosition: SnackPosition.BOTTOM,
    backgroundColor: Colors.redAccent,
    colorText: Colors.white,
    duration: const Duration(milliseconds: 2000),
    margin: const EdgeInsets.all(15),
  );
}

TimeOfDay convertStringToTimeOfDay(String timeString) {
  List<int> parts = timeString.split(':').map(int.parse).toList();

  TimeOfDay timeOfDay = TimeOfDay(hour: parts[0], minute: parts[1]);

  return timeOfDay;
}

String formatTimeOfDay(TimeOfDay timeOfDay) {
  String twoDigits(int n) => n.toString().padLeft(2, '0');
  return '${twoDigits(timeOfDay.hour)}:${twoDigits(timeOfDay.minute)}';
}

String formatAssetsUrl(String url) {
  return '${baseUrl}${url}';
}

String extractVideoId(String url) {
  RegExp regExp = RegExp(r'youtu\.be\/([a-zA-Z0-9_-]+)');
  Match? match = regExp.firstMatch(url);

  return match != null ? match.group(1)! : '6cwnBBAVIwE';
}
