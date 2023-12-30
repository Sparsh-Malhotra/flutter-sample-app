import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pathshala/app_contants.dart';
import 'package:pathshala/pages/attendance/models/attendee.dart';
import 'package:pathshala/pages/attendance/models/student.dart';
import 'package:pathshala/pages/attendance/views/attendace_card.dart';
import 'package:pathshala/pages/home/controllers/home_controller.dart';
import 'package:pathshala/services/api/attendance_service.dart';
import 'package:pathshala/utils/app_colors.dart';
import 'package:pathshala/utils/app_text_styles.dart';
import 'package:pathshala/utils/curves/small_curve.dart';
import 'package:pathshala/utils/functions.dart';
import 'package:pathshala/widgets/buttons/large_button.dart';
import 'package:pathshala/widgets/buttons/loading_button.dart';
import 'package:pathshala/widgets/widget_with_role.dart';

class AttendanceScreen extends StatefulWidget {
  AttendanceScreen({super.key, this.canEdit = true});
  bool canEdit = Get.parameters['canEdit'] == 'true';
  String? bhaag_class_section_id = Get.parameters['bhaag_class_section_id'];
  String? session_id = Get.parameters['session_id'];

  @override
  State<AttendanceScreen> createState() {
    return _AttendanceScreenState();
  }
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  final RxBool isLoading = false.obs;
  final AttendanceService _attendanceService = AttendanceService();
  final HomeController _homeController = Get.find();
  late final Rx<List<Attendee>> students;

  @override
  void initState() {
    super.initState();
    students = Rx<List<Attendee>>([]);
    fetchStudents();
  }

  Future<void> fetchStudents() async {
    try {
      isLoading.value = true;
      final response = await _attendanceService
          .getStudents(widget.bhaag_class_section_id ?? '');

      if (response.status == 'success') {
        PresentAttendeesResponse _presentAttendeesResponse =
            await fetchPresentAttendees();
        List<Attendee> temp = response.data.map((element) {
          return Attendee(
            id: element.id.toString(),
            name:
                '${element.profile['first_name']} ${element.profile['middle_name'] != null ? '${element.profile['middle_name'] + ' '}' : ''}${element.profile['last_name'] ?? ''}',
            alias: element.profile['alias'],
            isPresent: _presentAttendeesResponse.data.contains(element.id),
            profileId: element.profile['id'].toString(),
          );
        }).toList();

        students.value = temp;
      }
    } on DioException catch (e) {
      print(e);
      handleDioError(e);
    } catch (e) {
      print(e);
    } finally {
      isLoading.value = false;
    }
  }

  Future<dynamic> fetchPresentAttendees() async {
    try {
      final response = await _attendanceService.getPresentAttendees(
          DateFormat('yyyy-MM-dd').format(_homeController.selectedDate.value),
          widget.bhaag_class_section_id ?? '');

      if (response.status == 'success') {
        return response;
      }
    } on DioException catch (e) {
      print(e);
      handleDioError(e);
    } catch (e) {
      print(e);
    }
  }

  void handleDioError(DioException error) {
    final message =
        error.response?.data['error']['details'] ?? 'An error occurred';
    showErrorMessage(message);
  }

  void handleChangeAttendance(bool value, int index) {
    List<Attendee> temp = List.from(students.value);
    temp[index].isPresent = value;
    students.value = temp;
  }

  void handleChangeAlias(String profileId, String alias) {
    final temp = students.value;
    students.value = temp.map((element) {
      if (element.profileId == profileId) {
        element.alias = alias;
      }
      return element;
    }).toList();

    students.value = temp;
  }

  Future<void> showAttendancePreview() async {
    List<Attendee> present =
        students.value.where((stud) => stud.isPresent).toList();
    List<Attendee> absent =
        students.value.where((stud) => !stud.isPresent).toList();

    await Get.dialog(
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
                    '${students.value.length}',
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
  }

  Future<void> handleMarkAttendance() async {
    try {
      List<Attendee> present =
          students.value.where((stud) => stud.isPresent).toList();
      final response = await _attendanceService.markAttendance(
        {
          'session_id': widget.session_id,
          'students_ids':
              present.where((e) => e.isPresent).map((e) => e.id).toList(),
        },
      );

      if (response.status == 'success') {
        Get.toNamed('/home');
      }
    } on DioException catch (e) {
      print(e);
      handleDioError(e);
    } catch (e) {
      print(e);
    }
  }

  Widget footerButtons() {
    return Row(
      children: [
        Expanded(
          child: LargeButton(
            text: 'Preview',
            height: 55,
            onPress: showAttendancePreview,
          ),
        ),
        const SizedBox(
          width: 14,
        ),
        Expanded(
          child: SizedBox(
            height: 55,
            child: LoadingButton(
              text: 'Submit',
              onPress: handleMarkAttendance,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    double topBarHeight = 135;

    return Scaffold(
      body: Obx(
        () {
          return isLoading.value
              ? const Center(
                  child: CircularProgressIndicator(
                    color: AppColors.primary,
                  ),
                )
              : Stack(
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
                            itemCount: students.value.length,
                            itemBuilder: (context, index) => AttendanceCard(
                              name: students.value[index].name,
                              alias: students.value[index].alias,
                              isPresent: students.value[index].isPresent,
                              profileId: students.value[index].profileId,
                              onChangeAttendance: (value) {
                                handleChangeAttendance(value, index);
                              },
                              onChangeAlias: handleChangeAlias,
                            ),
                          ),
                          widget.canEdit
                              ? footerButtons()
                              : WidgetWithRole(
                                  allowedRoles: const [Roles.admin],
                                  child: footerButtons(),
                                ),
                        ],
                      ),
                    ),
                    CustomPaint(
                      size: Size(width, topBarHeight),
                      painter: SmallCurve(),
                      child: appBar(
                        'Attendance',
                        topBarHeight,
                      ),
                    ),
                  ],
                );
        },
      ),
    );
  }
}
