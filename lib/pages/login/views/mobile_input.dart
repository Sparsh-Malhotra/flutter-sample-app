import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pathshala/pages/home/models/user_details_model.dart';
import 'package:pathshala/pages/login/controllers/login_controller.dart';
import 'package:pathshala/utils/app_colors.dart';
import 'package:pathshala/utils/formatters.dart';
import 'package:pathshala/widgets/buttons/large_outlined_button.dart';
import 'package:pathshala/widgets/buttons/loading_button.dart';

class MobileInput extends StatefulWidget {
  const MobileInput({super.key, required this.onSubmit});

  final void Function() onSubmit;

  @override
  State<MobileInput> createState() {
    return _MobileInputState();
  }
}

class _MobileInputState extends State<MobileInput> {
  LoginController loginController = Get.put(LoginController());
  var _hasObscuredText = true.obs;

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
          child: Obx(
            () => Column(
              children: [
                const SizedBox(
                  height: 30,
                ),
                Container(
                  height: 55,
                  decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colors.grey),
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    children: [
                      TextField(
                        controller: loginController.usernameController,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                            RegExp(r"[a-zA-Z0-9]"),
                          ),
                          UpperCaseTextFormatter()
                        ],
                        textCapitalization: TextCapitalization.characters,
                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(
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
                        controller: loginController.passwordController,
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: _hasObscuredText.value,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Password",
                          prefixIcon: const Icon(Icons.lock),
                          suffixIcon: IconButton(
                            icon: _hasObscuredText.value
                                ? const Icon(Icons.visibility_off)
                                : const Icon(Icons.visibility),
                            onPressed: () {
                              _hasObscuredText.value = !_hasObscuredText.value;
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
                      child: Text(
                        'Sign up',
                        style: TextStyle(
                          color: AppColors.primarySwatch.shade800,
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 50,
                  width: width,
                  child: LoadingButton(
                    text: 'Login',
                    onPress: widget.onSubmit,
                  ),
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
                      GetStorage().write(
                        'user_details',
                        UserDetailsModel(
                          id: 0,
                          username: '',
                          email: '',
                          profile: UserProfile(
                            id: 0,
                            firstName: 'Guest',
                            middleName: '',
                            lastName: 'User',
                            dob: '',
                            phone: '',
                            alias: '',
                            email: '',
                            bloodGroup: '',
                            profilePicture: '',
                            gender: '',
                            groups: [0],
                          ),
                        ).toJson(),
                      );
                      Get.offNamed('/home');
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
