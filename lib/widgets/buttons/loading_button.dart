import 'package:com.jainyouthnoida.pathshala/utils/app_colors.dart';
import 'package:com.jainyouthnoida.pathshala/utils/app_text_styles.dart';
import 'package:easy_loading_button/easy_loading_button.dart';
import 'package:flutter/material.dart';

class LoadingButton extends StatelessWidget {
  const LoadingButton({
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
    return EasyButton(
      type: EasyButtonType.elevated,
      buttonColor: AppColors.primary,
      elevation: 0,
      useWidthAnimation: true,
      useEqualLoadingStateWidgetDimension: true,
      onPressed: onPress,
      borderRadius: 100,
      idleStateWidget: Text(
        text,
        style: AppTextStyle.regularWhite18,
      ),
      loadingStateWidget: const CircularProgressIndicator(
        strokeWidth: 5.0,
        valueColor: AlwaysStoppedAnimation<Color>(
          Colors.white,
        ),
      ),
    );
  }
}
