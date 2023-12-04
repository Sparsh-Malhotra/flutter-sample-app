import 'package:pathshala/utils/app_colors.dart';
import 'package:flutter/material.dart';

class ActionCard extends StatelessWidget {
  const ActionCard({
    Key? key,
    this.width,
    this.height,
    this.radius,
    this.margin,
    this.onTap,
    required this.child,
    this.bgColor,
    this.borderColor,
  }) : super(key: key);

  final double? width;
  final double? height;
  final double? radius;
  final EdgeInsets? margin;
  final Color? bgColor;
  final Color? borderColor;
  final Widget child;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: bgColor ?? AppColors.cardColor,
        borderRadius: BorderRadius.circular(radius ?? 15),
        border: Border.all(
          color: borderColor ?? Colors.transparent,
        ),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(radius ?? 15),
        onTap: onTap,
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: child),
      ),
    );
  }
}
