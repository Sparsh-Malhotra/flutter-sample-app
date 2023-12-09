import 'package:pathshala/utils/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DatePicker extends GetxController {
  Future<DateTime?> buildDatePicker(
      BuildContext context, DateTime selectedDate) async {
    DateTime? pickedDate;
    if (Theme.of(context).platform == TargetPlatform.iOS) {
      pickedDate = await buildCupertinoDatePicker(context, selectedDate);
    } else {
      pickedDate = await buildMaterialDatePicker(context, selectedDate);
    }
    return pickedDate;
  }

  Future<DateTime?> buildCupertinoDatePicker(
    BuildContext context,
    DateTime selectedDate,
  ) async {
    DateTime? pickedDate;
    await showModalBottomSheet(
      context: context,
      builder: (BuildContext builder) {
        return Container(
          height: MediaQuery.of(context).copyWith().size.height / 3,
          color: Colors.white,
          child: CupertinoDatePicker(
            mode: CupertinoDatePickerMode.date,
            onDateTimeChanged: (picked) {
              pickedDate = picked;
            },
            initialDateTime: selectedDate,
            minimumYear: 2000,
            maximumYear: 2035,
          ),
        );
      },
    );
    return pickedDate;
  }

  Future<DateTime?> buildMaterialDatePicker(
    BuildContext context,
    DateTime selectedDate,
  ) async {
    return await showDatePicker(
      context: context,
      currentDate: DateTime.now(),
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
      initialEntryMode: DatePickerEntryMode.calendar,
      initialDatePickerMode: DatePickerMode.day,
      // selectableDayPredicate: _decideWhichDayToEnable,
      helpText: 'Select Date',
      cancelText: 'Cancel',
      confirmText: 'Select',
      errorFormatText: 'Enter valid date',
      errorInvalidText: 'Enter date in valid range',
      fieldLabelText: 'Enter Date',
      fieldHintText: 'Month/Date/Year',
      builder: (context, child) {
        return Theme(
          data: ThemeData(
              visualDensity: VisualDensity.adaptivePlatformDensity,
              colorScheme:
                  ColorScheme.fromSwatch(primarySwatch: AppColors.primarySwatch)
                      .copyWith(secondary: Colors.transparent)),
          child: child!,
        );
      },
    );
  }

  Future<TimeOfDay?> buildMaterialTimePicker(BuildContext context) async {
    return await showTimePicker(
      initialTime: TimeOfDay.now(),
      context: context,
      helpText: 'Select booking time',
      cancelText: 'Not now',
      confirmText: 'Confirm',
      // errorInvalidText: 'Enter time in valid range',
      builder: (context, child) {
        return Theme(
          data: ThemeData.dark(),
          child: child!,
        );
      },
    );
  }
}
