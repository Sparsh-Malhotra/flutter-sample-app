import 'package:flutter/material.dart';
import 'package:pathshala/utils/app_colors.dart';
import 'package:pathshala/widgets/large_button.dart';
import 'package:pinput/pinput.dart';

class OTPVerify extends StatefulWidget {
  OTPVerify({super.key, required this.onSubmit});

  void Function() onSubmit;

  @override
  State<OTPVerify> createState() {
    return _OTPVerifyState();
  }
}

class _OTPVerifyState extends State<OTPVerify> {
  final pinController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    const focusedBorderColor = AppColors.primary;
    const fillColor = Color.fromRGBO(243, 246, 249, 0);

    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: const TextStyle(
        fontSize: 22,
        color: Color.fromRGBO(30, 60, 87, 1),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(19),
        border: Border.all(color: AppColors.primary),
      ),
    );

    return SizedBox(
      child: Container(
        height: height * 0.5,
        width: width,
        decoration: const BoxDecoration(color: AppColors.primary),
        child: Container(
          padding: const EdgeInsets.only(left: 30, right: 30, top: 30),
          decoration: const BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(25),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 50,
              ),
              Form(
                key: formKey,
                child: Column(
                  children: [
                    Directionality(
                      // Specify direction if desired
                      textDirection: TextDirection.ltr,
                      child: Pinput(
                        controller: pinController,
                        androidSmsAutofillMethod:
                            AndroidSmsAutofillMethod.smsRetrieverApi,
                        listenForMultipleSmsOnAndroid: true,
                        separatorBuilder: (index) => const SizedBox(width: 8),
                        validator: (value) {
                          return value == '1234' ? null : 'Pin is incorrect';
                        },
                        hapticFeedbackType: HapticFeedbackType.lightImpact,
                        onCompleted: (pin) {
                          print('onCompleted: $pin');
                        },
                        cursor: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(bottom: 9),
                              width: 22,
                              height: 1,
                              // color: focusedBorderColor,
                            ),
                          ],
                        ),
                        focusedPinTheme: defaultPinTheme.copyWith(
                          decoration: defaultPinTheme.decoration!.copyWith(
                            borderRadius: BorderRadius.circular(8),
                            border:
                                Border.all(color: focusedBorderColor, width: 2),
                          ),
                        ),
                        submittedPinTheme: defaultPinTheme.copyWith(
                          decoration: defaultPinTheme.decoration!.copyWith(
                            color: fillColor,
                            borderRadius: BorderRadius.circular(19),
                            border: Border.all(color: focusedBorderColor),
                          ),
                        ),
                        errorPinTheme: defaultPinTheme.copyBorderWith(
                          border: Border.all(color: Colors.redAccent),
                        ),
                        pinputAutovalidateMode: PinputAutovalidateMode.disabled,
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              SizedBox(
                height: 50,
                width: width,
                child: LargeButton(
                  text: 'Submit OTP',
                  onPress: () {
                    if (formKey.currentState!.validate()) {
                      widget.onSubmit();
                    }
                  },
                ),
              ),
              SizedBox(
                height: height * 0.1,
              )
            ],
          ),
        ),
      ),
    );
  }
}
