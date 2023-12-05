import 'package:flutter/material.dart';
import 'package:pathshala/utils/app_colors.dart';
import 'package:pathshala/utils/app_text_styles.dart';

Widget inputFile({
  label,
  bool required = true,
  TextInputType keyboardType = TextInputType.text,
  obscureText = false,
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
        obscureText: obscureText,
        keyboardType: keyboardType,
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.primary)),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.primarySplash),
          ),
          border: OutlineInputBorder(
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
