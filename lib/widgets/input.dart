import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pathshala/utils/app_colors.dart';
import 'package:pathshala/utils/app_text_styles.dart';
import 'package:pathshala/utils/formatters.dart';

Widget inputFile({
  label,
  bool required = true,
  TextInputType keyboardType = TextInputType.text,
  bool readOnly = false,
  obscureText = false,
  Widget? suffixIcon,
  void Function()? onTap,
  String? value,
  TextEditingController? controller,
  void Function(String)? onChange,
  void Function(String?)? onSave,
  String? Function(String?)? validator,
  bool? isUsername,
}) {
  final List<TextInputFormatter> inputFormatters = [];
  if (isUsername != null && isUsername) {
    inputFormatters.add(FilteringTextInputFormatter.allow(
      RegExp(r"[a-zA-Z0-9]"),
    ));
    inputFormatters.add(UpperCaseTextFormatter());
  }

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
        controller: controller != null
            ? controller
            : value != null
                ? TextEditingController(text: value)
                : null,
        readOnly: readOnly,
        obscureText: obscureText,
        keyboardType: keyboardType,
        onTap: onTap,
        onChanged: onChange,
        onSaved: onSave,
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
        validator: validator,
        inputFormatters: inputFormatters,
        textCapitalization: isUsername != null && isUsername
            ? TextCapitalization.characters
            : TextCapitalization.none,
      ),
      const SizedBox(
        height: 10,
      )
    ],
  );
}
