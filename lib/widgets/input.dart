import 'package:flutter/material.dart';
import 'package:pathshala/utils/app_colors.dart';
import 'package:pathshala/utils/app_text_styles.dart';

Widget inputFile({
  label,
  bool required = true,
  TextInputType keyboardType = TextInputType.text,
  bool readOnly = false,
  obscureText = false,
  Widget? suffixIcon,
  void Function()? onTap,
  String? value,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Row(
        children: [
          Text(
            label,
            style: AppTextStyle.regularBlack16,
          ),
          if (required)
            Text(
              '*',
              style: const TextStyle().copyWith(
                color: Colors.redAccent,
              ),
            )
        ],
      ),
      const SizedBox(
        height: 5,
      ),
      TextFormField(
        readOnly: readOnly,
        initialValue: value,
        obscureText: obscureText,
        keyboardType: keyboardType,
        onTap: onTap,
        decoration: InputDecoration(
          suffixIcon: suffixIcon,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
          focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.primary)),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.primarySplash),
          ),
          border: const OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.primary),
          ),
        ),
      ),
      const SizedBox(
        height: 10,
      )
    ],
  );
}
