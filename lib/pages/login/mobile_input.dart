import 'package:flutter/material.dart';
import 'package:pathshala/utils/app_colors.dart';
import 'package:pathshala/widgets/large_button.dart';
import 'package:pathshala/widgets/large_outlined_button.dart';

class MobileInput extends StatefulWidget {
  const MobileInput({super.key, required this.onSubmit});

  final void Function() onSubmit;

  State<MobileInput> createState() {
    return _MobileInputState();
  }
}

class _MobileInputState extends State<MobileInput> {
  TextEditingController countryController = TextEditingController();

  @override
  void initState() {
    countryController.text = "+91";
    super.initState();
  }

  @override
  void dispose() {
    countryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return SizedBox(
      height: height * 0.5,
      child: Container(
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
            children: [
              const SizedBox(
                height: 30,
              ),
              Container(
                height: 55,
                decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.grey),
                    borderRadius: BorderRadius.circular(10)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      width: 10,
                    ),
                    SizedBox(
                      width: 40,
                      child: TextField(
                        controller: countryController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    const Text(
                      "|",
                      style: TextStyle(fontSize: 33, color: Colors.grey),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    const Expanded(
                      child: TextField(
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Phone",
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const Spacer(),
              SizedBox(
                height: 50,
                width: width,
                child: LargeButton(text: 'Send OTP', onPress: widget.onSubmit),
              ),
              const SizedBox(
                height: 30,
              ),
              SizedBox(
                height: 50,
                width: width,
                child: LargeOutlinedButton(
                    text: 'Continue as Guest', onPress: () {}),
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
