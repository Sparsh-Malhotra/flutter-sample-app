import 'package:pathshala/utils/app_text_styles.dart';
import 'package:pathshala/utils/app_colors.dart';
import 'package:flutter/material.dart';

class LargeButton extends StatelessWidget {
  const LargeButton({
    Key? key,
    required this.text,
    required this.onPress,
    this.height,
  }) : super(key: key);
  final String text;
  final double? height;
  final Function() onPress;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100.0),
          ),
        ),
        onPressed: onPress,
        child: Text(
          text,
          style: AppTextStyle.regularWhite16,
        ),
      ),
    );
  }
}
