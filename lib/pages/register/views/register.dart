import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pathshala/app_contants.dart';
import 'package:pathshala/utils/app_colors.dart';
import 'package:pathshala/utils/curves/small_curve.dart';
import 'package:pathshala/utils/functions.dart';
import 'package:pathshala/widgets/input.dart';
import 'package:pathshala/widgets/large_button.dart';
import 'package:pathshala/widgets/pickers/date_picker.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() {
    return _RegisterScreenState();
  }
}

class _RegisterScreenState extends State<RegisterScreen> {
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
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        inputFile(label: 'First Name'),
                        inputFile(
                          label: 'Middle Name',
                          required: false,
                        ),
                        inputFile(label: 'Last Name'),
                        inputFile(
                          label: 'Date of birth',
                          readOnly: true,
                          suffixIcon: const Icon(
                            Icons.calendar_month,
                            color: AppColors.primary,
                          ),
                          onTap: () async {
                            final temp = await DatePicker()
                                    .buildMaterialDatePicker(context) ??
                                DateTime.now();
                          },
                          value: '${DateFormat('dd/MM/yyyy').format(
                            DateTime.now(),
                          )}',
                        ),
                        inputFile(
                          label: 'Phone',
                          keyboardType: TextInputType.phone,
                        ),
                        inputFile(
                          label: 'Email',
                          keyboardType: TextInputType.emailAddress,
                          required: false,
                        ),
                        inputFile(
                          label: 'Username',
                          keyboardType: TextInputType.text,
                        ),
                        CustomDropdown<String>(
                          hintText: 'Select role',
                          items: roles,
                          onChanged: (value) {},
                          closedBorder: Border.all(
                            color: AppColors.primarySplash,
                          ),
                          expandedBorder: Border.all(
                            color: AppColors.primary,
                          ),
                          hintBuilder: (ctx, text) => Text(text),
                          headerBuilder: (ctx, text) => Text(text),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          height: 50,
                          width: width,
                          child: LargeButton(
                            text: 'Register',
                            onPress: () {},
                          ),
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
