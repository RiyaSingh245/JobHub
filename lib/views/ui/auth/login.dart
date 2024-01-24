import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:job_hub/constants/app_constants.dart';
import 'package:job_hub/controllers/exports.dart';
import 'package:job_hub/models/request/auth/login_model.dart';
import 'package:job_hub/views/common/app_bar.dart';
import 'package:job_hub/views/common/app_style.dart';
import 'package:job_hub/views/common/custom_btn.dart';
import 'package:job_hub/views/common/custom_textfield.dart';
import 'package:job_hub/views/common/height_spacer.dart';
import 'package:job_hub/views/common/reusable_text.dart';
import 'package:job_hub/views/ui/auth/signup.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LoginNotifier>(
      builder: (context, loginNotifier, child) {
        loginNotifier.getPrefs();
        return Scaffold(
          appBar: PreferredSize(
              preferredSize: const Size.fromRadius(50),
              child: CustomAppBar(
                  text: "Login",
                  child: loginNotifier.entrypoint && loginNotifier.loggedIn
                      ? GestureDetector(
                          onTap: () {
                            Get.back();
                          },
                          child: const Icon(
                            CupertinoIcons.arrow_left,
                          ),
                        )
                      : const SizedBox.shrink())),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                const HeightSpacer(size: 50),
                ReusableText(
                  text: "Welcome Back",
                  style: appstyle(
                    30,
                    Color(kDark.value),
                    FontWeight.w600,
                  ),
                ),
                ReusableText(
                  text: "Fill the details to login to your account",
                  style: appstyle(
                    16,
                    Color(kDarkGrey.value),
                    FontWeight.w600,
                  ),
                ),
                const HeightSpacer(size: 50),
                CustomTextField(
                  controller: email,
                  hintText: "Email",
                  keyboardType: TextInputType.emailAddress,
                  validator: (email) {
                    if (email!.isEmpty || !email.contains("@")) {
                      return "Please enter a valid email";
                    } else {
                      return null;
                    }
                  },
                ),
                const HeightSpacer(size: 20),
                CustomTextField(
                  controller: password,
                  hintText: "Password",
                  keyboardType: TextInputType.text,
                  obscureText: loginNotifier.obscureText,
                  validator: (password) {
                    if (password!.isEmpty || password.length < 8) {
                      return "Please enter a valid password";
                    } else {
                      return null;
                    }
                  },
                  suffixIcon: GestureDetector(
                    onTap: () {
                      loginNotifier.obscureText = !loginNotifier.obscureText;
                    },
                    child: Icon(
                      loginNotifier.obscureText
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: Color(kDark.value),
                    ),
                  ),
                ),
                const HeightSpacer(size: 10),
                Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: () {
                      Get.offAll(() => const RegistrationPage());
                    },
                    child: ReusableText(
                      text: "Register",
                      style: appstyle(
                        14,
                        Color(kDark.value),
                        FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                const HeightSpacer(size: 50),
                CustomButton(
                  onTap: () {
                    if (loginNotifier.validateAndSave()) {
                      LoginModel model = LoginModel(
                          email: email.text, password: password.text);

                      loginNotifier.userLogin(model);
                    } else {
                      Get.snackbar(
                          "Sign Failed", "Please check your credentials",
                          colorText: Color(kLight.value),
                          backgroundColor: Colors.red,
                          icon: const Icon(Icons.add_alert));
                    }
                  },
                  text: "Login",
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
