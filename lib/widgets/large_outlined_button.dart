import 'package:pathshala/utils/app_text_styles.dart';
import 'package:pathshala/utils/app_colors.dart';
import 'package:flutter/material.dart';

class LargeOutlinedButton extends StatelessWidget {
  const LargeOutlinedButton({
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
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(100.0),
            ),
            side: const BorderSide(color: AppColors.primary)),
        onPressed: onPress,
        child: Text(
          text,
          style: AppTextStyle.regularPrimary16,
        ),
      ),
    );
  }
}
