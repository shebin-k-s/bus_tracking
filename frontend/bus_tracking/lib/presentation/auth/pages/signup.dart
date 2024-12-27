import 'package:bus_tracking/common/helpers/navigation.dart';
import 'package:bus_tracking/common/widgets/app_bar/app_bar.dart';
import 'package:bus_tracking/common/widgets/button/basic_app_button.dart';
import 'package:bus_tracking/common/widgets/snack_bar/custom_snack_bar.dart';
import 'package:bus_tracking/data/models/auth/auth_req_params.dart';
import 'package:bus_tracking/domain/usecases/auth/signup.dart';
import 'package:bus_tracking/presentation/auth/cubit/button/button_cubit.dart';
import 'package:bus_tracking/presentation/auth/pages/signin.dart';
import 'package:bus_tracking/presentation/auth/widgets/basic_text_form_field.dart';
import 'package:bus_tracking/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formkey = GlobalKey<FormState>();

    final TextEditingController emailController =
        TextEditingController(text: "shebh@gecskp.ac.in");
    final TextEditingController nameController =
        TextEditingController(text: "ssss");
    final TextEditingController passwordController =
        TextEditingController(text: "ssss");
    final TextEditingController confirmPasswordController =
        TextEditingController(text: "ssss");
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
      body: BlocProvider(
        create: (context) => ButtonCubit(),
        child: BlocListener<ButtonCubit, ButtonState>(
          listenWhen: (previous, current) =>
              current is ButtonFailureState || current is ButtonSuccessState,
          listener: (context, state) {
            if (state is ButtonSuccessState) {
              CustomSnackBar.show(
                context: context,
                message: state.message,
                isError: false,
              );
              return AppNavigator.pushReplacement(
                  context, const SigninScreen());
            }
          },
          child: SingleChildScrollView(
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
                  BlocBuilder<ButtonCubit, ButtonState>(
                    builder: (context, state) {
                      if (state is ButtonFailureState) {
                        return SizedBox(
                          width: double.infinity,
                          child: Padding(
                            padding: EdgeInsets.only(bottom: 16.h),
                            child: Text(
                              state.message,
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 16.sp,
                              ),
                            ),
                          ),
                        );
                      } else {
                        return const SizedBox.shrink();
                      }
                    },
                  ),
                  Form(
                    key: formkey,
                    child: Column(
                      children: [
                        BasicTextFormField(
                          controller: nameController,
                          icon: Icons.person,
                          label: "Full name",
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Name cannot be empty";
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 15.h,
                        ),
                        BasicTextFormField(
                          controller: emailController,
                          icon: Icons.mail,
                          label: "Email id",
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Email cannot be empty";
                            }
                            if (!value.endsWith('@gecskp.ac.in')) {
                              return "Only gecskp.ac.in domain are allowed";
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 15.h,
                        ),
                        BasicTextFormField(
                          controller: passwordController,
                          icon: Icons.lock,
                          label: "Password",
                          obscureText: true,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Password cannot be empty";
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 15.h,
                        ),
                        BasicTextFormField(
                          controller: confirmPasswordController,
                          icon: Icons.lock,
                          label: "Confirm password",
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Confirm Password cannot be empty";
                            }
                            if (value != passwordController.text) {
                              return "Passwords do not match";
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 40.h,
                        ),
                        BlocBuilder<ButtonCubit, ButtonState>(
                          builder: (context, state) {
                            return BasicAppButton(
                              onPressed: () {
                                if (formkey.currentState!.validate() &&
                                    state is! ButtonLoadingState) {
                                  FocusScope.of(context).unfocus();
                                  context.read<ButtonCubit>().execute(
                                        usecase: sl<SignupUseCase>(),
                                        params: AuthReqParams(
                                          email: emailController.text,
                                          fullName: nameController.text,
                                          password: passwordController.text,
                                        ),
                                      );
                                }
                              },
                              isLoading: state is ButtonLoadingState,
                              width: 353.w,
                              title: "SIGN UP",
                            );
                          },
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
