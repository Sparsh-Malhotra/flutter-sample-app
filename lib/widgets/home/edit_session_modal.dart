import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pathshala/pages/home/controllers/home_controller.dart';
import 'package:pathshala/pages/home/models/session_model.dart';
import 'package:pathshala/utils/app_colors.dart';
import 'package:pathshala/utils/app_text_styles.dart';
import 'package:pathshala/utils/functions.dart';
import 'package:pathshala/widgets/loading_button.dart';
import 'package:pathshala/widgets/pickers/date_picker.dart';

class EditSessionModal extends StatefulWidget {
  const EditSessionModal({
    super.key,
    required this.bhaagName,
    required this.time,
    required this.section,
    required this.mentorList,
    required this.currentMentor,
    required this.onSubmit,
    required this.postSubmit,
  });

  final String bhaagName;
  final String section;
  final String time;
  final Map<String, dynamic> currentMentor;
  final List<TeamModel> mentorList;
  final Function(
    DateTime selectedDate,
    TimeOfDay selectedTime,
    String mentor,
  ) onSubmit;
  final Function() postSubmit;

  @override
  State<EditSessionModal> createState() {
    return _EditSessionModalState();
  }
}

class _EditSessionModalState extends State<EditSessionModal> {
  final HomeController _homeController = Get.find();

  late final Rx<DateTime> _selectedDate;
  late final Rx<TimeOfDay> _selectedTime;
  late final RxString _mentor;

  late final List<MentorModel> mentorList;

  @override
  void initState() {
    _selectedDate = Rx<DateTime>(_homeController.selectedDate.value);
    _selectedTime = Rx<TimeOfDay>(convertStringToTimeOfDay(widget.time));
    mentorList = widget.mentorList.isEmpty
        ? [
            MentorModel(
              id: widget.currentMentor['id'],
              name: widget.currentMentor['name'],
            )
          ]
        : widget.mentorList
            .map(
              (mentor) => MentorModel(
                name: '${mentor.profile.firstName} ${mentor.profile.lastName}',
                id: mentor.id,
              ),
            )
            .toList();
    _mentor = RxString(widget.currentMentor['id'].toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Container(
      width: width,
      height: height * 0.65,
      padding: const EdgeInsets.all(20.0),
      child: ListView(
        shrinkWrap: true,
        children: [
          Align(
            child: Text(
              'Edit Session',
              style: AppTextStyle.boldBlack20,
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          Text(
            'Session Name',
            style: AppTextStyle.mediumBlack14,
          ),
          Text(
            widget.bhaagName,
            style: AppTextStyle.mediumBlack20,
          ),
          const SizedBox(
            height: 15,
          ),
          Text(
            'Section',
            style: AppTextStyle.mediumBlack14,
          ),
          Text(
            widget.section,
            style: AppTextStyle.mediumBlack20,
          ),
          const SizedBox(
            height: 15,
          ),
          Text(
            'Date',
            style: AppTextStyle.mediumBlack14,
          ),
          const SizedBox(
            height: 3,
          ),
          Obx(
            () => TextField(
              controller: TextEditingController(
                text: DateFormat('dd/MM/yyyy').format(_selectedDate.value),
              ),
              readOnly: true,
              decoration: const InputDecoration(
                suffixIcon: Icon(Icons.calendar_month),
                contentPadding:
                    EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.grey)),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.grey),
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.grey),
                ),
              ),
              onTap: () async {
                final selectedDate = await DatePicker().buildDatePicker(
                  context,
                  _selectedDate.value,
                );
                if (selectedDate != null) {
                  _selectedDate.value = selectedDate;
                }
              },
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Text(
            'Time',
            style: AppTextStyle.mediumBlack14,
          ),
          const SizedBox(
            height: 3,
          ),
          Obx(
            () => TextField(
              controller: TextEditingController(
                text: _selectedTime.value.format(context),
              ),
              readOnly: true,
              decoration: const InputDecoration(
                suffixIcon: Icon(Icons.access_time),
                contentPadding:
                    EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.grey)),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.grey),
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.grey),
                ),
              ),
              onTap: () async {
                final selectedTime = await DatePicker().buildTimePicker(
                  context,
                  _selectedTime.value,
                  'Select Session time',
                );
                if (selectedTime != null) {
                  _selectedTime.value = selectedTime;
                }
              },
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            'Mentor',
            style: AppTextStyle.mediumBlack14,
          ),
          CustomDropdown<String>(
            hintText: '',
            initialItem: widget.currentMentor['name'],
            items: mentorList.map((mentor) => mentor.name).toList(),
            onChanged: (value) {
              _mentor.value = mentorList
                  .where((mentor) => mentor.name == value)
                  .toList()[0]
                  .id
                  .toString();
            },
            closedBorder: Border.all(
              color: AppColors.primarySplash,
            ),
            expandedBorder: Border.all(
              color: AppColors.primary,
            ),
            closedBorderRadius: const BorderRadius.all(
              Radius.circular(5),
            ),
            expandedBorderRadius: const BorderRadius.all(
              Radius.circular(5),
            ),
            closedFillColor: Colors.transparent,
            hintBuilder: (ctx, text) => Text(text),
            headerBuilder: (ctx, text) => Text(
              text,
              style: AppTextStyle.regularBlack16,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            height: 50,
            child: LoadingButton(
              text: 'Submit',
              onPress: () async {
                await widget.onSubmit(
                  _selectedDate.value,
                  _selectedTime.value,
                  _mentor.value,
                );
                await widget.postSubmit();
              },
            ),
          ),
        ],
      ),
    );
  }
}
