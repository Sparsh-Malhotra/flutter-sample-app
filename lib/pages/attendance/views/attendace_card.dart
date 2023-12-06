import 'package:flutter/material.dart';
import 'package:pathshala/utils/app_colors.dart';
import 'package:pathshala/utils/app_text_styles.dart';
import 'package:pathshala/widgets/cards/action_card.dart';

class AttendanceCard extends StatefulWidget {
  AttendanceCard(
      {super.key,
      required this.name,
      this.alias,
      required this.isPresent,
      required this.onChangeAttendance});

  final String name;
  final String? alias;
  final bool isPresent;
  void Function(bool value) onChangeAttendance;

  @override
  State<AttendanceCard> createState() => _AttendanceCardState();
}

class _AttendanceCardState extends State<AttendanceCard> {
  // Future<dynamic> addAlias() {
  //   return Get.defaultDialog(
  //     title: 'Add Alias',
  //     titleStyle: AppTextStyle.mediumBlack20,
  //     cancel: OutlinedButton(
  //       onPressed: () {
  //         Get.back();
  //       },
  //       style: OutlinedButton.styleFrom(
  //           side: const BorderSide(color: AppColors.primary)),
  //       child: Text(
  //         'Cancel',
  //         style: const TextStyle().copyWith(
  //           color: AppColors.primary,
  //         ),
  //       ),
  //     ),
  //     confirm: ElevatedButton(
  //       onPressed: () {
  //         Get.back();
  //       },
  //       style: ElevatedButton.styleFrom(
  //         backgroundColor: AppColors.primary,
  //       ),
  //       child: Text(
  //         'Add',
  //         style: const TextStyle().copyWith(
  //           color: AppColors.white,
  //         ),
  //       ),
  //     ),
  //     contentPadding: const EdgeInsets.only(
  //       left: 10,
  //       right: 10,
  //       bottom: 10,
  //       top: 5,
  //     ),
  //     content: SizedBox(
  //       width: 350,
  //       child: Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: <Widget>[
  //           Row(
  //             children: [
  //               Text(
  //                 'Add alias for ${widget.name}',
  //                 style: AppTextStyle.regularBlack14,
  //               ),
  //             ],
  //           ),
  //           const SizedBox(
  //             height: 8,
  //           ),
  //           TextFormField(
  //             initialValue: widget.alias,
  //             decoration: const InputDecoration(
  //               contentPadding: EdgeInsets.symmetric(
  //                 vertical: 0,
  //                 horizontal: 10,
  //               ),
  //               focusedBorder: OutlineInputBorder(
  //                 borderSide: BorderSide(color: AppColors.primary),
  //               ),
  //               enabledBorder: OutlineInputBorder(
  //                 borderSide: BorderSide(color: AppColors.primarySplash),
  //               ),
  //               border: OutlineInputBorder(
  //                 borderSide: BorderSide(color: AppColors.primary),
  //               ),
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return ActionCard(
      margin: const EdgeInsets.only(bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              children: [
                Text(
                  widget.name,
                  style: AppTextStyle.mediumBlack18,
                ),
                if (widget.alias != null)
                  Text(
                    ' (${widget.alias})',
                    style: AppTextStyle.regularBlack14,
                  ),
              ],
            ),
          ),
          Switch(
            value: widget.isPresent,
            onChanged: (value) {
              widget.onChangeAttendance(value);
            },
            activeTrackColor: AppColors.primary,
          )
        ],
      ),
    );
  }
}
