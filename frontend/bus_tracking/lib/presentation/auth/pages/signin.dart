import 'package:bus_tracking/common/helpers/is_dark_mode.dart';
import 'package:bus_tracking/common/helpers/navigation.dart';
import 'package:bus_tracking/common/widgets/app_bar/app_bar.dart';
import 'package:bus_tracking/common/widgets/button/basic_app_button.dart';
import 'package:bus_tracking/common/widgets/snack_bar/custom_snack_bar.dart';
import 'package:bus_tracking/data/models/auth/auth_req_params.dart';
import 'package:bus_tracking/domain/usecases/auth/signin.dart';
import 'package:bus_tracking/presentation/auth/cubit/button/button_cubit.dart';
import 'package:bus_tracking/presentation/auth/pages/signup.dart';
import 'package:bus_tracking/presentation/auth/widgets/basic_text_form_field.dart';
import 'package:bus_tracking/presentation/main/pages/main_screen.dart';
import 'package:bus_tracking/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SigninScreen extends StatelessWidget {
  const SigninScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formkey = GlobalKey<FormState>();

    final TextEditingController emailController =
        TextEditingController(text: "shebh@gecskp.ac.in");
    final TextEditingController passwordController =
        TextEditingController(text: "shebin");
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
            onTap: () =>
                AppNavigator.pushReplacement(context, const SignupScreen()),
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
      body: BlocProvider(
        create: (context) => ButtonCubit(),
        child: BlocListener<ButtonCubit, ButtonState>(
          listener: (context, state) async {
            if (state is ButtonSuccessState) {
              CustomSnackBar.show(
                context: context,
                message: state.message,
                isError: false,
              );
              return AppNavigator.pushAndRemoveUntil(
                  context, const MainScreen());
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
                    "Hey,\nWelcome\nBack",
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
                                color: context.isDarkMode
                                    ? Colors.white
                                    : Colors.black,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 30.h,
                        ),
                        BlocBuilder<ButtonCubit, ButtonState>(
                          builder: (context, state) {
                            return BasicAppButton(
                              onPressed: () {
                                if (formkey.currentState!.validate() &&
                                    state is! ButtonLoadingState) {
                                  FocusScope.of(context).unfocus();
                                  context.read<ButtonCubit>().execute(
                                        usecase: sl<SigninUseCase>(),
                                        params: AuthReqParams(
                                          email: emailController.text,
                                          password: passwordController.text,
                                        ),
                                      );
                                }
                              },
                              isLoading: state is ButtonLoadingState,
                              width: 353.w,
                              title: "LOGIN",
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
