import 'package:bus_tracking/common/helpers/navigation.dart';
import 'package:bus_tracking/common/widgets/app_bar/app_bar.dart';
import 'package:bus_tracking/common/widgets/button/basic_app_button.dart';
import 'package:bus_tracking/presentation/auth/pages/signin.dart';
import 'package:bus_tracking/presentation/auth/widgets/basic_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formkey = GlobalKey<FormState>();

    final TextEditingController emailController = TextEditingController();
    final TextEditingController nameController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    final TextEditingController confirmPasswordController = TextEditingController();
    return Scaffold(
      appBar: const BasicAppbar(),
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Already have an account? ",
            style: TextStyle(
              fontSize: 14.sp,
            ),
          ),
          GestureDetector(
            onTap: () =>
                AppNavigator.pushReplacement(context, const SigninScreen()),
            child: Text(
              "Login",
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
                "Let's\nGet\nStarted",
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
                      controller: nameController,
                      icon: Icons.person,
                      label: "Full name",
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
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
                     SizedBox(
                      height: 15.h,
                    ),
                    BasicTextFormField(
                      controller: confirmPasswordController,
                      icon: Icons.lock,
                      label: "Confirm password",
                    ),
                    SizedBox(
                      height: 40.h,
                    ),
                    BasicAppButton(
                      onPressed: () {},
                      width: 353.w,
                      title: "SIGN UP",
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
