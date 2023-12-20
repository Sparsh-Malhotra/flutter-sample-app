import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pathshala/pages/home/models/user_details_model.dart';
import 'package:pathshala/services/api/user_service.dart';
import 'package:pathshala/utils/app_colors.dart';
import 'package:pathshala/utils/app_text_styles.dart';
import 'package:pathshala/utils/functions.dart';
import 'package:pathshala/widgets/cards/action_card.dart';

class AttendanceCard extends StatefulWidget {
  AttendanceCard({
    super.key,
    required this.name,
    this.alias,
    required this.isPresent,
    required this.profileId,
    required this.onChangeAttendance,
    required this.onChangeAlias,
  });

  final String name;
  final String? alias;
  final bool isPresent;
  final String profileId;
  void Function(bool value) onChangeAttendance;
  void Function(String id, String alias) onChangeAlias;

  @override
  State<AttendanceCard> createState() => _AttendanceCardState();
}

class _AttendanceCardState extends State<AttendanceCard> {
  late TextEditingController _aliasController;
  final _formKey = GlobalKey<FormState>();
  final UserService _userService = UserService();
  RxBool isLoading = false.obs;

  @override
  void initState() {
    super.initState();
    _aliasController = TextEditingController(text: widget.alias ?? '');
  }

  @override
  void dispose() {
    _aliasController.dispose();
    super.dispose();
  }

  Future<void> handleAddAlias() async {
    try {
      isLoading.value = true;
      UserDetailsModel response = await _userService.updateProfile({
        'user_profile_id': widget.profileId,
        'profile.alias': _aliasController.text,
      });
      widget.onChangeAlias(widget.profileId, _aliasController.text);
      Get.back();
    } on Exception catch (e) {
      showErrorMessage(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<dynamic> addAlias() {
    return Get.defaultDialog(
      backgroundColor: AppColors.white,
      title: 'Add Alias',
      titleStyle: AppTextStyle.mediumBlack20,
      cancel: OutlinedButton(
        onPressed: () {
          Get.back();
        },
        style: OutlinedButton.styleFrom(
            side: const BorderSide(color: AppColors.primary)),
        child: Text(
          'Cancel',
          style: const TextStyle().copyWith(
            color: AppColors.primary,
          ),
        ),
      ),
      confirm: Obx(
        () => ElevatedButton(
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              _formKey.currentState!.save();
              await handleAddAlias();
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
          ),
          child: isLoading.value
              ? const CircularProgressIndicator(
                  color: Colors.white,
                )
              : Text(
                  'Add',
                  style: const TextStyle().copyWith(
                    color: AppColors.white,
                  ),
                ),
        ),
      ),
      contentPadding: const EdgeInsets.only(
        left: 10,
        right: 10,
        bottom: 10,
        top: 5,
      ),
      content: SizedBox(
        width: 350,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: [
                Text(
                  'Add alias for ${widget.name}',
                  style: AppTextStyle.regularBlack14,
                ),
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            Form(
              key: _formKey,
              child: TextFormField(
                controller: _aliasController,
                validator: (value) {
                  if (value == null || value.trim() == '') {
                    return 'Enter valid alias';
                  } else if (value == widget.alias) {
                    return 'Enter a different alias to update';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 0,
                    horizontal: 10,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.primary),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.primarySplash),
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.primary),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ActionCard(
      onTap: addAlias,
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
