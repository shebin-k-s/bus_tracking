import 'dart:developer';

import 'package:bus_tracking/common/helpers/is_dark_mode.dart';
import 'package:bus_tracking/common/helpers/navigation.dart';
import 'package:bus_tracking/common/widgets/button/basic_app_button.dart';
import 'package:bus_tracking/core/configs/assets/app_images.dart';
import 'package:bus_tracking/core/configs/assets/app_text.dart';
import 'package:bus_tracking/core/configs/theme/app_colors.dart';
import 'package:bus_tracking/presentation/auth/pages/signin.dart';
import 'package:bus_tracking/presentation/auth/pages/signup.dart';
import 'package:bus_tracking/presentation/onboarding/bloc/carousel/carousel_cubit.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class IntroData {
  final String imagePath;
  final String message;

  IntroData({required this.imagePath, required this.message});
}

class OnboardingScreen1 extends StatelessWidget {
  OnboardingScreen1({super.key});
  final CarouselSliderController carouselController =
      CarouselSliderController();
  @override
  Widget build(BuildContext context) {
    log("onboarding refreshing");

    final List<IntroData> introData = [
      IntroData(
        imagePath: AppImages.busImage,
        message: AppText.welcomeMessage1,
      ),
      IntroData(
        imagePath: AppImages.busStop1,
        message: AppText.welcomeMessage2,
      ),
      IntroData(
        imagePath: AppImages.busStop2,
        message: AppText.welcomeMessage3,
      ),
      IntroData(
        imagePath: AppImages.busStop3,
        message: AppText.welcomeMessage4,
      ),
    ];

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 95.h,
              ),
              Text(
                "WELCOME TO APPNAME",
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w800,
                ),
              ),
              SizedBox(
                height: 35.h,
              ),
              CarouselSlider(
                carouselController: carouselController,
                options: CarouselOptions(
                  viewportFraction: 1,
                  height: 450.h,
                  enableInfiniteScroll: false,
                  onPageChanged: (index, reason) {
                    log('Page changed to index: $index');
                    context.read<CarouselCubit>().updateIndex(index);
                  },
                ),
                items: introData.map(
                  (data) {
                    return SizedBox(
                      width: double.infinity,
                      child: Column(
                        children: [
                          SizedBox(
                            width: 363.w,
                            height: 221.w,
                            child: Image.asset(data.imagePath),
                          ),
                          SizedBox(
                            height: 45.h,
                          ),
                          Text(
                            data.message,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 15.sp,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ).toList(),
              ),
              BlocBuilder<CarouselCubit, CarouselState>(
                builder: (context, state) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 10.w,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return Container(
                              width: 10.w,
                              height: 10.w,
                              decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.circular(2),
                                color: state.currentIndex == index
                                    ? AppColors.primary
                                    : const Color(0xffD9D9D9),
                              ),
                            );
                          },
                          separatorBuilder: (context, index) => SizedBox(
                            width: 5.w,
                          ),
                          itemCount: introData.length,
                        ),
                      ),
                      SizedBox(
                        height: 22.h,
                      ),
                      if (state.currentIndex != 3) ...{
                        BasicAppButton(
                          onPressed: () {
                            carouselController.nextPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.linear,
                            );
                          },
                          title: state.currentIndex == 2
                              ? "LET'S GET START"
                              : "NEXT",
                        )
                      } else
                        Container(
                          height: 48.h,
                          width: 313.w,
                          decoration: BoxDecoration(
                            color: AppColors.primary.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: () {
                                    AppNavigator.push(
                                      context,
                                      const SigninScreen(),
                                    );
                                  },
                                  child: const Text(
                                    "LOGIN",
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: () {
                                    AppNavigator.push(
                                      context,
                                      const SignupScreen(),
                                    );
                                  },
                                  style: ButtonStyle(
                                    backgroundColor: WidgetStateProperty.all(
                                      Colors.transparent,
                                    ),
                                    elevation: WidgetStateProperty.all(0),
                                  ),
                                  child: Text(
                                    "SIGN UP",
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                      color: context.isDarkMode
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
