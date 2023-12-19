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
      lastDate: DateTime(2035),
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

  Future<TimeOfDay?> buildTimePicker(
      BuildContext context, TimeOfDay selectedTime,
      [String? hintText]) async {
    TimeOfDay? pickedTime;
    if (Theme.of(context).platform == TargetPlatform.iOS) {
      pickedTime = await buildCupertinoTimePicker(context, selectedTime);
    } else {
      pickedTime =
          await buildMaterialTimePicker(context, selectedTime, hintText);
    }
    return pickedTime;
  }

  Future<TimeOfDay?> buildCupertinoTimePicker(
    BuildContext context,
    TimeOfDay selectedTime,
  ) async {
    TimeOfDay? pickedTime;
    await showModalBottomSheet(
      context: context,
      builder: (BuildContext builder) {
        return Container(
          height: MediaQuery.of(context).copyWith().size.height / 3,
          color: Colors.white,
          child: CupertinoDatePicker(
            mode: CupertinoDatePickerMode.time,
            onDateTimeChanged: (picked) {
              pickedTime = TimeOfDay.fromDateTime(
                DateTime(
                  DateTime.now().year,
                  DateTime.now().month,
                  DateTime.now().day,
                  picked.hour,
                  picked.minute,
                ),
              );
            },
            initialDateTime: DateTime(
              DateTime.now().year,
              DateTime.now().month,
              DateTime.now().day,
              selectedTime.hour,
              selectedTime.minute,
            ),
          ),
        );
      },
    );
    return pickedTime;
  }

  Future<TimeOfDay?> buildMaterialTimePicker(
    BuildContext context,
    TimeOfDay selectedTime,
    String? hintText,
  ) async {
    return await showTimePicker(
      context: context,
      initialTime: selectedTime,
      helpText: hintText,
      cancelText: 'Cancel',
      confirmText: 'Confirm',
    );
  }
}
