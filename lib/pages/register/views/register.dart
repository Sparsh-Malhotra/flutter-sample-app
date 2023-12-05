import 'package:flutter/material.dart';
import 'package:pathshala/utils/app_colors.dart';
import 'package:pathshala/utils/curves/small_curve.dart';
import 'package:pathshala/utils/functions.dart';
import 'package:pathshala/widgets/input.dart';
import 'package:pathshala/widgets/large_button.dart';

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
                        inputFile(label: 'Date of birth'),
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
                        inputFile(
                          label: 'Role',
                          keyboardType: TextInputType.text,
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
