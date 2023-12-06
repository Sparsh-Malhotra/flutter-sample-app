import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pathshala/pages/attendance/models/student.dart';
import 'package:pathshala/pages/attendance/views/attendace_card.dart';
import 'package:pathshala/utils/app_colors.dart';
import 'package:pathshala/utils/app_text_styles.dart';
import 'package:pathshala/utils/curves/small_curve.dart';
import 'package:pathshala/utils/functions.dart';
import 'package:pathshala/widgets/large_button.dart';

class AttendanceScreen extends StatefulWidget {
  AttendanceScreen({super.key, this.canEdit = true});
  bool canEdit = Get.parameters['canEdit'] == 'true';

  @override
  State<AttendanceScreen> createState() {
    return _AttendanceScreenState();
  }
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  static List<Student> students = [
    Student(name: 'Sparsh', alias: 'Sasta Larry Page'),
    Student(name: 'Harshit'),
  ];

  void handleChangeAttendance(bool value, int index) {
    List<Student> temp = students;
    temp[index].isPresent = value;
    setState(() {
      students = temp;
    });
  }

  Future<dynamic> Function() showAttendancePreview = () {
    List<Student> present = students.where((stud) => stud.isPresent).toList();
    List<Student> absent = students.where((stud) => !stud.isPresent).toList();

    return Get.dialog(
      Dialog(
        backgroundColor: AppColors.white,
        child: Container(
          padding: const EdgeInsets.fromLTRB(10, 15, 10, 15),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.center,
                child: Text(
                  'Attendance Preview',
                  style: AppTextStyle.mediumBlack20,
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              Row(
                children: [
                  Text(
                    'Total Students :-  ',
                    style: AppTextStyle.boldBlack16,
                  ),
                  Text(
                    '${students.length}',
                    style: AppTextStyle.mediumBlack16,
                  ),
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  Text(
                    'Present Students :-  ',
                    style: AppTextStyle.boldBlack16,
                  ),
                  Text(
                    '${present.length}',
                    style: AppTextStyle.mediumBlack16,
                  ),
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  Text(
                    'Absent Students :-  ',
                    style: AppTextStyle.boldBlack16,
                  ),
                  Text(
                    '${absent.length}',
                    style: AppTextStyle.mediumBlack16,
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
            ],
          ),
        ),
      ),
    );
  };

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    double topBarHeight = 135;

    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            height: height,
            width: width,
            child: ListView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.only(
                  left: 20, right: 20, top: 132, bottom: 20),
              children: [
                ListView.builder(
                  padding: const EdgeInsets.only(bottom: 20),
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: students.length,
                  itemBuilder: (context, index) => AttendanceCard(
                    name: students[index].name,
                    alias: students[index].alias,
                    isPresent: students[index].isPresent,
                    onChangeAttendance: (value) {
                      handleChangeAttendance(value, index);
                    },
                  ),
                ),
                widget.canEdit
                    ? Row(
                        children: [
                          Expanded(
                            child: LargeButton(
                              text: 'Preview',
                              height: 55,
                              onPress: () {
                                showAttendancePreview();
                              },
                            ),
                          ),
                          const SizedBox(
                            width: 14,
                          ),
                          Expanded(
                            child: LargeButton(
                              text: 'Upload',
                              height: 55,
                              onPress: () {},
                            ),
                          ),
                        ],
                      )
                    : Container(),
              ],
            ),
          ),
          CustomPaint(
            size: Size(width, topBarHeight), // small 135, medium 155
            painter: SmallCurve(),
            child: appBar(
              'Attendance',
              topBarHeight,
            ),
          ),
        ],
      ),
    );
  }
}
