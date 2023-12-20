import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomAlertDialogController extends GetxController {
  void showCustomAlertDialog({
    required String cancelText,
    required String confirmText,
    required VoidCallback onConfirm,
    required String headingText,
    required String description,
  }) {
    if (GetPlatform.isIOS) {
      showCupertinoDialog(
        context: Get.overlayContext!,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            title: Text(headingText),
            content: Text(description),
            actions: <Widget>[
              CupertinoDialogAction(
                child: Text(cancelText),
                onPressed: () {
                  Get.back();
                },
              ),
              CupertinoDialogAction(
                child: Text(confirmText),
                onPressed: () {
                  onConfirm();
                  Get.back();
                },
              ),
            ],
          );
        },
      );
    } else {
      Get.defaultDialog(
        title: headingText,
        content: Text(description),
        textCancel: cancelText,
        textConfirm: confirmText,
        cancelTextColor: Colors.red,
        confirmTextColor: Colors.blue,
        onConfirm: () {
          onConfirm();
          Get.back();
        },
        onCancel: () {
          Get.back();
        },
      );
    }
  }
}
