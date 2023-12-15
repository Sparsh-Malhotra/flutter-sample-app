import 'package:flutter/material.dart';

class TopBar extends StatelessWidget {
  const TopBar({
    Key? key,
    required this.height,
    required this.width,
    required this.leading,
    required this.title,
    this.trailing,
  }) : super(key: key);

  final double height;
  final double width;
  final Widget leading;
  final Widget title;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: Container(
        padding: const EdgeInsets.only(top: 0, left: 20, right: 20),
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/appbar_vector.png'),
            fit: BoxFit.fitWidth,
            alignment: Alignment.topCenter,
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                leading,
                const SizedBox(
                  width: 20,
                ),
                title
              ],
            ),
            trailing ?? Container(),
          ],
        ),
      ),
    );
  }
}
