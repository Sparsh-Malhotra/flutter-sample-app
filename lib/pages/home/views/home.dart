import 'package:get_storage/get_storage.dart';
import 'package:pathshala/pages/home/controllers/home_controller.dart';
import 'package:pathshala/services/api/user_service.dart';
import 'package:pathshala/utils/app_colors.dart';
import 'package:pathshala/utils/app_text_styles.dart';
import 'package:pathshala/utils/curves/medium_curve.dart';
import 'package:pathshala/utils/functions.dart';
import 'package:pathshala/widgets/cards/topbar.dart';
import 'package:pathshala/widgets/cards/action_card.dart';
import 'package:pathshala/widgets/pickers/date_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

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

  Future<void> _loadUserDetails() async {
    try {
      isLoading.value = true;
      final userDetails = await _userService.getUserDetails();

      // Store user details in GetStorage
      GetStorage().write('user_details', userDetails.toJson());
    } catch (e) {
      // Handle errors
      print('Error loading user details: $e');
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

  @override
  void initState() {
    super.initState();
    if (!GetStorage().hasData('user_details')) _loadUserDetails();
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
                          ActionCard(
                            height: 60,
                            margin: const EdgeInsets.only(bottom: 20),
                            borderColor: AppColors.primary,
                            bgColor: Colors.transparent,
                            onTap: () async {
                              final selectedDate = await DatePicker()
                                  .buildDatePicker(
                                      context, dashboardC.selectedDate.value);

                              if (selectedDate != null) {
                                dashboardC.selectedDate.value = selectedDate;
                              }
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                          Text(
                            'Mark Attendance',
                            style: AppTextStyle.boldBlack18,
                          ),
                          ListView.builder(
                            shrinkWrap: true,
                            itemCount: classes.length,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return ActionCard(
                                width: width,
                                height: 70,
                                radius: 15,
                                margin: const EdgeInsets.only(bottom: 10),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        'Class ${classes[index]}',
                                        style: AppTextStyle.mediumBlack18,
                                      ),
                                    ),
                                    dashboardC.selectedDate.value.day != today
                                        ? IconButton(
                                            onPressed: () => {
                                              Get.toNamed(
                                                'attendance',
                                                parameters: {
                                                  'canEdit': 'false',
                                                },
                                              )
                                            },
                                            icon: const Icon(
                                              Icons.remove_red_eye,
                                              color: AppColors.primary,
                                            ),
                                          )
                                        : Container(),
                                    dashboardC.selectedDate.value.day == today
                                        ? IconButton(
                                            onPressed: () => {
                                              Get.toNamed(
                                                '/attendance',
                                                parameters: {
                                                  'canEdit': 'true',
                                                },
                                              ),
                                            },
                                            icon: const Icon(
                                              Icons.edit,
                                              color: AppColors.primary,
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
                              backgroundImage: const NetworkImage(
                                  'https://i.pravatar.cc/300'),
                              radius: 24,
                            ),
                          ),
                          title: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${userDetails['profile']['first_name']} ${userDetails['profile']['last_name']}',
                                style: AppTextStyle.mediumBlack18
                                    .copyWith(color: AppColors.white),
                              ),
                              Text(
                                'English Department',
                                style: AppTextStyle.regularWhite14,
                              ),
                            ],
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
