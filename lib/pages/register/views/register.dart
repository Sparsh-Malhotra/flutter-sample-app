import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pathshala/app_contants.dart';
import 'package:pathshala/pages/register/controllers/register_controller.dart';
import 'package:pathshala/utils/app_colors.dart';
import 'package:pathshala/utils/app_text_styles.dart';
import 'package:pathshala/utils/curves/small_curve.dart';
import 'package:pathshala/utils/functions.dart';
import 'package:pathshala/widgets/input.dart';
import 'package:pathshala/widgets/loading_button.dart';
import 'package:pathshala/widgets/pickers/date_picker.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() {
    return _RegisterScreenState();
  }
}

class _RegisterScreenState extends State<RegisterScreen> {
  RegisterController registerController = Get.put(RegisterController());

  final _registerFormKey = GlobalKey<FormState>();

  void handleRegister() async {
    if (_registerFormKey.currentState!.validate()) {
      _registerFormKey.currentState!.save();
      await registerController.register();
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    double topBarHeight = height * 0.16;

    return Scaffold(
      backgroundColor: AppColors.white,
      body: Stack(
        children: [
          SizedBox(
            height: height,
            width: width,
            child: Padding(
              padding: EdgeInsets.only(
                top: height * 0.15,
                left: 20,
                right: 20,
              ),
              child: Center(
                child: Form(
                  key: _registerFormKey,
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        inputFile(
                          label: 'First Name',
                          onSave: (value) {
                            registerController.firstName.value = value!;
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'This field is required';
                            } else if (!value.isAlphabetOnly) {
                              return 'Please enter valid name';
                            }
                            return null;
                          },
                        ),
                        inputFile(
                          label: 'Middle Name',
                          required: false,
                          onSave: (value) {
                            registerController.middleName.value = value!;
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return null;
                            } else if (!value.isAlphabetOnly) {
                              return 'Please enter valid name';
                            }
                            return null;
                          },
                        ),
                        inputFile(
                          label: 'Last Name',
                          onSave: (value) {
                            registerController.lastName.value = value!;
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'This field is required';
                            } else if (!value.isAlphabetOnly) {
                              return 'Please enter valid name';
                            }
                            return null;
                          },
                        ),
                        Obx(
                          () {
                            // debugPrint('reload');
                            return inputFile(
                              label: 'Date of birth',
                              readOnly: true,
                              suffixIcon: const Icon(
                                Icons.calendar_month,
                                color: AppColors.primary,
                              ),
                              onTap: () async {
                                final selectedDate =
                                    await DatePicker().buildDatePicker(
                                  context,
                                  DateFormat('dd/MM/yyyy')
                                      .parse(registerController.dob.value),
                                );
                                if (selectedDate != null) {
                                  registerController.dob.value =
                                      DateFormat('dd/MM/yyyy')
                                          .format(selectedDate);
                                }
                              },
                              value: registerController.dob.value,
                            );
                          },
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            'Blood Group',
                            style: AppTextStyle.regularBlack16,
                          ),
                        ),
                        CustomDropdown<String>(
                          hintText: '',
                          items: bloodGroups,
                          onChanged: (value) {
                            registerController.bloodGroup.value = value;
                          },
                          closedBorder: Border.all(
                            color: AppColors.primarySplash,
                          ),
                          expandedBorder: Border.all(
                            color: AppColors.primary,
                          ),
                          hintBuilder: (ctx, text) => Text(text),
                          headerBuilder: (ctx, text) => Text(text),
                        ),
                        Align(
                            alignment: Alignment.topLeft,
                            child: Row(
                              children: [
                                Text(
                                  'Gender',
                                  style: AppTextStyle.regularBlack16,
                                ),
                                // Text(
                                //   '*',
                                //   style: const TextStyle().copyWith(
                                //     color: Colors.redAccent,
                                //   ),
                                // )
                              ],
                            )),
                        CustomDropdown<String>(
                          hintText: '',
                          items: genderOptions,
                          onChanged: (value) {
                            registerController.gender.value = value;
                          },
                          closedBorder: Border.all(
                            color: AppColors.primarySplash,
                          ),
                          expandedBorder: Border.all(
                            color: AppColors.primary,
                          ),
                          hintBuilder: (ctx, text) => Text(text),
                          headerBuilder: (ctx, text) => Text(text),
                          // validator: (value) {
                          //   if (value == null) {
                          //     return "Please select a gender";
                          //   }
                          //   return null;
                          // },
                          errorStyle: const TextStyle().copyWith(
                            fontSize: 12,
                          ),
                        ),
                        inputFile(
                          label: 'Phone',
                          keyboardType: TextInputType.phone,
                          onSave: (value) {
                            registerController.phone.value = value!;
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'This field is required';
                            } else if (!value.isNumericOnly ||
                                value.length != 10) {
                              return 'Please enter valid phone number';
                            }
                            return null;
                          },
                        ),
                        inputFile(
                          label: 'Email',
                          keyboardType: TextInputType.emailAddress,
                          required: false,
                          onSave: (value) {
                            registerController.email.value = value!;
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'This field is required';
                            } else if (!value.isEmail) {
                              return 'Please enter valid phone number';
                            }
                            return null;
                          },
                        ),
                        inputFile(
                          label: 'Username',
                          keyboardType: TextInputType.text,
                          onSave: (value) {
                            registerController.username.value = value!;
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'This field is required';
                            }
                            return null;
                          },
                        ),
                        inputFile(
                          label: 'Password',
                          keyboardType: TextInputType.text,
                          onSave: (value) {
                            registerController.password.value = value!;
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'This field is required';
                            }
                            return null;
                          },
                        ),
                        CustomDropdown<String>(
                          hintText: 'Select role',
                          items: Roles.values.map((e) => e.name).toList(),
                          onChanged: (value) {
                            registerController.role.value = Roles.values
                                    .where((role) => role.name == value)
                                    .toList()[0]
                                    .index +
                                1;
                          },
                          closedBorder: Border.all(
                            color: AppColors.primarySplash,
                          ),
                          expandedBorder: Border.all(
                            color: AppColors.primary,
                          ),
                          hintBuilder: (ctx, text) => Text(text),
                          headerBuilder: (ctx, text) => Text(text),
                          validator: (value) {
                            if (value == null) {
                              return "Please select a role";
                            }
                            return null;
                          },
                          errorStyle: const TextStyle().copyWith(
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          height: 50,
                          width: width,
                          child: LoadingButton(
                            text: 'Register',
                            onPress: handleRegister,
                          ),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          CustomPaint(
            size: Size(width, topBarHeight), // small 135, medium 155
            painter: SmallCurve(),
            child: appBar(
              'Register Account',
              topBarHeight,
            ),
          ),
        ],
      ),
    );
  }
}
