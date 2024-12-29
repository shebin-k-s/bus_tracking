import 'package:bus_tracking/core/configs/theme/app_colors.dart';
import 'package:bus_tracking/presentation/auth/widgets/basic_text_form_field.dart';
import 'package:bus_tracking/presentation/home/bloc/bus/bus_cubit.dart';
import 'package:bus_tracking/presentation/home/widgets/bus_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<BusCubit>().fetchBuses();
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                  color: AppColors.primary,
                  borderRadius:
                      BorderRadius.vertical(bottom: Radius.circular(30))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Hey,",
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    " Shebin ks",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 18.sp,
                    ),
                  ),
                  const SizedBox(
                    height: 35,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        height: 45,
                        width: MediaQuery.of(context).size.width * 0.75,
                        child: TextSelectionTheme(
                          data: TextSelectionThemeData(
                            selectionColor: Colors.black.withOpacity(0.8),
                            selectionHandleColor: Colors.white.withOpacity(0.3),
                          ),
                          child: BasicTextFormField(
                            controller: TextEditingController(),
                            label: "Enter destination",
                            labelSize: 12.w,
                            mainColor: Colors.white,
                            iconColor: Colors.white,
                            prefixIcon: Icons.location_on_outlined,
                          ),
                        ),
                      ),
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: const Center(
                          child: Text(
                            "GO",
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 16,
                  top: 16,
                  right: 16,
                ),
                child: BlocBuilder<BusCubit, BusState>(
                  builder: (context, state) {
                    if (state is BusLoaded) {
                      return ListView.builder(
                        itemBuilder: (context, index) {
                          return  Column(
                            children: [
                              BusCard(
                                bus: state.buses[index],
                              ),
                              const SizedBox(
                                height: 10,
                              )
                            ],
                          );
                        },
                        itemCount: state.buses.length,
                      );
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
