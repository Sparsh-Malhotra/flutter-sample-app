import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pathshala/utils/app_colors.dart';
import 'package:pathshala/widgets/large_button.dart';
import 'package:pathshala/widgets/large_outlined_button.dart';

class MobileInput extends StatefulWidget {
  const MobileInput({super.key, required this.onSubmit});

  final void Function() onSubmit;

  @override
  State<MobileInput> createState() {
    return _MobileInputState();
  }
}

class _MobileInputState extends State<MobileInput> {
  var _hasObscuredText = false;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return SizedBox(
      // height: 0.5 * height,
      child: Container(
        width: width,
        margin: const EdgeInsets.only(bottom: 12),
        decoration: const BoxDecoration(color: AppColors.primary),
        child: Container(
          padding: const EdgeInsets.only(left: 30, right: 30, top: 0),
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
                child: const Column(
                  children: [
                    TextField(
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Username",
                        prefixIcon: Icon(Icons.person),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                height: 55,
                decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.grey),
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  children: [
                    TextField(
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: _hasObscuredText,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Password",
                        prefixIcon: const Icon(Icons.lock),
                        suffixIcon: IconButton(
                          icon: _hasObscuredText
                              ? const Icon(Icons.visibility_off)
                              : const Icon(Icons.visibility),
                          onPressed: () {
                            setState(() {
                              _hasObscuredText = !_hasObscuredText;
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  const Text('Don\'t have an account ?'),
                  TextButton(
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.only(left: 0),
                    ),
                    onPressed: () {
                      Get.toNamed('/register');
                    },
                    child: Text('Sign up',
                        style: TextStyle(
                          color: AppColors.primarySwatch.shade800,
                        )),
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 50,
                width: width,
                child: LargeButton(text: 'Login', onPress: widget.onSubmit),
              ),
              const SizedBox(
                height: 8,
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: height * 0.01),
                width: width * 0.8,
                child: const Row(
                  children: <Widget>[
                    Expanded(
                      child: Divider(
                        color: Color(0xFFD9D9D9),
                        height: 1.5,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        "OR",
                        style: TextStyle(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        color: Color(0xFFD9D9D9),
                        height: 1.5,
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              SizedBox(
                height: 50,
                width: width,
                child: LargeOutlinedButton(
                    text: 'Continue as Guest',
                    onPress: () {
                      Get.toNamed('/home');
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
