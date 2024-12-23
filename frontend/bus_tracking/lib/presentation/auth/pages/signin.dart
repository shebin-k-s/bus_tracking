import 'package:bus_tracking/common/helpers/is_dark_mode.dart';
import 'package:bus_tracking/common/helpers/navigation.dart';
import 'package:bus_tracking/common/widgets/app_bar/app_bar.dart';
import 'package:bus_tracking/common/widgets/button/basic_app_button.dart';
import 'package:bus_tracking/presentation/auth/pages/signup.dart';
import 'package:bus_tracking/presentation/auth/widgets/basic_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SigninScreen extends StatelessWidget {
  const SigninScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formkey = GlobalKey<FormState>();

    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    return Scaffold(
      appBar: const BasicAppbar(),
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Don't have an account? ",
            style: TextStyle(
              fontSize: 14.sp,
            ),
          ),
          GestureDetector(
            onTap: () => AppNavigator.pushReplacement(context, const SignupScreen()),
            child: Text(
              "Sign Up",
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 14.sp,
              ),
            ),
          ),
          const SizedBox(
            height: 70,
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 50,
              ),
              Text(
                "Hey,\nWelcome\nBack",
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 28.sp,
                ),
              ),
              SizedBox(
                height: 50.h,
              ),
              Form(
                key: formkey,
                child: Column(
                  children: [
                    BasicTextFormField(
                      controller: emailController,
                      icon: Icons.mail,
                      label: "Email id",
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    BasicTextFormField(
                      controller: passwordController,
                      icon: Icons.lock,
                      label: "Password",
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {},
                        style: const ButtonStyle(
                            overlayColor: WidgetStatePropertyAll(
                          Colors.transparent,
                        )),
                        child: Text(
                          "Forgot Password?",
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                            color:
                                context.isDarkMode ? Colors.white : Colors.black,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    BasicAppButton(
                      onPressed: () {},
                      width: 353.w,
                      title: "LOGIN",
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
