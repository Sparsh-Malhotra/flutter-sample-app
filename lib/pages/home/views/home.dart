import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:pathshala/app_contants.dart';
import 'package:pathshala/pages/home/controllers/home_controller.dart';
import 'package:pathshala/services/api/user_service.dart';
import 'package:pathshala/utils/app_colors.dart';
import 'package:pathshala/utils/app_text_styles.dart';
import 'package:pathshala/utils/curves/medium_curve.dart';
import 'package:pathshala/utils/functions.dart';
import 'package:pathshala/widgets/cards/topbar.dart';
import 'package:pathshala/widgets/cards/action_card.dart';
import 'package:pathshala/widgets/home/edit_session_modal.dart';
import 'package:pathshala/widgets/pickers/date_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pathshala/widgets/widget_with_role.dart';
import 'package:toggle_switch/toggle_switch.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen> {
  final RxBool isLoading = false.obs;

  double topBarHeight = 135;
  double appBarPad = 6.0;
  int today = DateTime.now().day;

  List classes = ['6th A', '7th B', '8th A', '9th C', '10th A'];

  HomeController dashboardC = Get.put(HomeController());
  final UserService _userService = UserService();
  RxString sessionMode = 'offline'.obs;

  Future<void> fetchData() async {
    try {
      isLoading.value = true;

      final List<Future<dynamic>> futures = [];

      if (GetStorage().hasData('access_token')) {
        futures.add(_userService.getSessions(
          DateFormat('yyyy-MM-dd').format(dashboardC.selectedDate.value),
        ));
      }

      if (!GetStorage().hasData('user_details')) {
        futures.add(_userService.getUserDetails());
      }

      final responses = await Future.wait<dynamic>(futures);
      dashboardC.sessions.value = responses[0];
      if (responses.length > 1) {
        GetStorage().write('user_details', responses[1].toJson());
      }
    } on DioException catch (e) {
      handleDioError(e);
    } catch (e) {
      print(e);
    } finally {
      isLoading.value = false;
    }
  }

  Widget menuItem(String image, String title, Function() onTap, {int? flex}) {
    return Expanded(
      flex: flex ?? 1,
      child: GestureDetector(
        onTap: onTap,
        child: SizedBox(
          height: 108,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 80,
                width: 80,
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.primary, width: 2),
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Image.asset(
                  'assets/images/$image',
                ),
              ),
              Text(
                title,
                style: AppTextStyle.boldPrimary14,
              )
            ],
          ),
        ),
      ),
    );
  }

  void handleDioError(DioException error) {
    final message =
        error.response?.data['error']['details'] ?? 'An error occurred';
    showErrorMessage(message);
  }

  @override
  void initState() {
    super.initState();
    ever(dashboardC.selectedDate, (_) {
      fetchData();
    });
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColors.white,
      body: Obx(
        () {
          final userDetails = GetStorage().read('user_details');
          final modifiedSessions = dashboardC.sessions.value
              .where((session) => session.mode == sessionMode.value)
              .toList();
          return isLoading.value || userDetails == null
              ? const Center(
                  child: CircularProgressIndicator(
                    color: AppColors.primary,
                  ),
                )
              : Stack(
                  children: [
                    SizedBox(
                      width: width,
                      height: height,
                      child: ListView(
                        physics: const BouncingScrollPhysics(),
                        padding: const EdgeInsets.only(
                            left: 20, right: 20, top: 153, bottom: 20),
                        children: [
                          Row(
                            children: [
                              menuItem(
                                  'homework_icon.png', 'Homework', () => {}),
                              menuItem('notice_board_icon.png', 'Notice Board',
                                  () => {}),
                              menuItem(
                                  'calendar_icon.png', 'Timetable', () => {}),
                            ],
                          ),
                          const SizedBox(
                            height: 18,
                          ),
                          WidgetWithRole(
                            allowedRoles: const [
                              Roles.mentor,
                              Roles.admin,
                            ],
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ActionCard(
                                  height: 60,
                                  margin: const EdgeInsets.only(bottom: 20),
                                  borderColor: AppColors.primary,
                                  bgColor: Colors.transparent,
                                  onTap: () async {
                                    final selectedDate = await DatePicker()
                                        .buildDatePicker(context,
                                            dashboardC.selectedDate.value);

                                    if (selectedDate != null) {
                                      dashboardC.selectedDate.value =
                                          selectedDate;
                                    }
                                  },
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Icon(
                                        Icons.calendar_month,
                                        color: AppColors.primary,
                                      ),
                                      Text(
                                        '${formatDate(dashboardC.selectedDate.value.toString())}',
                                        style: AppTextStyle.mediumPrimary18,
                                      ),
                                      const SizedBox(
                                        width: 26,
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Mark Attendance',
                                      style: AppTextStyle.boldBlack18,
                                    ),
                                    ToggleSwitch(
                                      minWidth: 67.0,
                                      initialLabelIndex:
                                          sessionMode.value == 'offline'
                                              ? 0
                                              : 1,
                                      cornerRadius: 20.0,
                                      activeFgColor: Colors.white,
                                      inactiveBgColor: AppColors.primarySplash,
                                      inactiveFgColor: Colors.white,
                                      totalSwitches: 2,
                                      labels: const ['Offline', 'Online'],
                                      activeBgColors: const [
                                        [AppColors.primary],
                                        [AppColors.primary]
                                      ],
                                      onToggle: (index) {
                                        if (index == 0) {
                                          sessionMode.value = 'offline';
                                        } else {
                                          sessionMode.value = 'online';
                                        }
                                      },
                                    ),
                                  ],
                                ),
                                dashboardC.sessions.value.isEmpty ||
                                        modifiedSessions.isEmpty
                                    ? SizedBox(
                                        height: height * 0.4,
                                        child: const Center(
                                          child: Text(
                                            'No sessions for the selected date!',
                                          ),
                                        ),
                                      )
                                    : ListView.builder(
                                        shrinkWrap: true,
                                        itemCount: modifiedSessions.length,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemBuilder: (context, index) {
                                          final sessionName =
                                              modifiedSessions[index]
                                                  .bhaagClassSection
                                                  .bhaagClass
                                                  .bhaagCategory
                                                  .bhaag
                                                  .name;
                                          final section =
                                              modifiedSessions[index]
                                                  .bhaagClassSection
                                                  .section;
                                          return ActionCard(
                                            width: width,
                                            height: 70,
                                            radius: 15,
                                            margin: const EdgeInsets.only(
                                              bottom: 10,
                                            ),
                                            onTap: () {
                                              showModalBottomSheet(
                                                isScrollControlled: true,
                                                backgroundColor:
                                                    AppColors.white,
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return EditSessionModal(
                                                    bhaagName: sessionName,
                                                    section: section,
                                                    onSubmit:
                                                        (DateTime selectedDate,
                                                            String textValue) {
                                                      // Handle the submitted data here
                                                      print(
                                                          'Selected Date: $selectedDate');
                                                      print(
                                                          'Text Value: $textValue');
                                                    },
                                                  );
                                                },
                                              );
                                            },
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  child: Text(
                                                    '$sessionName ($section)',
                                                    style: AppTextStyle
                                                        .mediumBlack18,
                                                  ),
                                                ),
                                                dashboardC.selectedDate.value
                                                            .day !=
                                                        today
                                                    ? IconButton(
                                                        onPressed: () => {
                                                          Get.toNamed(
                                                            'attendance',
                                                            parameters: {
                                                              'canEdit':
                                                                  'false',
                                                              'bhaag_class_section_id':
                                                                  modifiedSessions[
                                                                          index]
                                                                      .bhaagClassSection
                                                                      .id
                                                                      .toString(),
                                                              'session_id':
                                                                  modifiedSessions[
                                                                          index]
                                                                      .id
                                                                      .toString(),
                                                            },
                                                          )
                                                        },
                                                        icon: const Icon(
                                                          Icons.remove_red_eye,
                                                          color:
                                                              AppColors.primary,
                                                        ),
                                                      )
                                                    : Container(),
                                                dashboardC.selectedDate.value
                                                            .day ==
                                                        today
                                                    ? IconButton(
                                                        onPressed: () => {
                                                          Get.toNamed(
                                                            '/attendance',
                                                            parameters: {
                                                              'canEdit': 'true',
                                                              'bhaag_class_section_id':
                                                                  modifiedSessions[
                                                                          index]
                                                                      .bhaagClassSection
                                                                      .id
                                                                      .toString(),
                                                              'session_id':
                                                                  modifiedSessions[
                                                                          index]
                                                                      .id
                                                                      .toString(),
                                                            },
                                                          ),
                                                        },
                                                        icon: const Icon(
                                                          Icons.edit,
                                                          color:
                                                              AppColors.primary,
                                                        ),
                                                      )
                                                    : Container(),
                                              ],
                                            ),
                                          );
                                        },
                                      ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    // Top Bar
                    CustomPaint(
                      size: Size(width, topBarHeight), // small 135, medium 155
                      painter: MediumCurve(),
                      child: Padding(
                        padding: EdgeInsets.only(bottom: appBarPad),
                        child: TopBar(
                          height: topBarHeight,
                          width: width,
                          leading: GestureDetector(
                            onTap: () => {},
                            child: CircleAvatar(
                              backgroundColor:
                                  AppColors.secondary.withOpacity(0.5),
                              backgroundImage: NetworkImage(
                                userDetails['profile']['profile_picture'] == ''
                                    ? genderPlaceholderImages[
                                        userDetails['profile']['gender']]
                                    : userDetails['profile']['profile_picture'],
                              ),
                              radius: 24,
                            ),
                          ),
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${userDetails['profile']['first_name']} ${userDetails['profile']['last_name']}',
                                    style: AppTextStyle.mediumBlack18
                                        .copyWith(color: AppColors.white),
                                  ),
                                  Text(
                                    '${Roles.values[userDetails['profile']['groups'][0]].name}',
                                    style: AppTextStyle.regularWhite14,
                                  ),
                                ],
                              ),
                            ],
                          ),
                          trailing: dashboardC.isLogoutLoading.value
                              ? const CircularProgressIndicator(
                                  color: Colors.white,
                                )
                              : IconButton(
                                  onPressed: () {
                                    dashboardC.logoutHandler();
                                  },
                                  icon: const Icon(
                                    Icons.logout,
                                    color: Colors.white,
                                  ),
                                ),
                        ),
                      ),
                    ),
                  ],
                );
        },
      ),
    );
  }
}
