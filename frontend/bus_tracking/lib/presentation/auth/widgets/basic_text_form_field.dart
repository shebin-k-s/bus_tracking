import 'package:bus_tracking/common/helpers/is_dark_mode.dart';
import 'package:bus_tracking/core/configs/theme/app_colors.dart';
import 'package:bus_tracking/presentation/auth/cubit/password_visibility/password_visibility_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BasicTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final IconData icon;
  final FormFieldValidator<String>? validator;
  final bool obscureText;

  const BasicTextFormField({
    super.key,
    required this.controller,
    required this.label,
    required this.icon,
    this.validator,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PasswordVisibilityCubit(),
      child: BlocBuilder<PasswordVisibilityCubit, PasswordVisibilityState>(
        builder: (context, state) {
          return TextFormField(
            controller: controller,
            validator: validator,
            obscureText: obscureText && !state.showPassword,
            cursorColor: AppColors.primary,
            
            decoration: InputDecoration(
              labelText: label,
              errorBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.red.withOpacity(0.75),
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              errorStyle: TextStyle(color: Colors.red.withOpacity(0.75)),
              labelStyle: TextStyle(
                fontSize: 14,
                color: context.isDarkMode
                    ? Colors.white.withOpacity(0.75)
                    : Colors.black.withOpacity(0.75),
              ),
              suffixIcon: obscureText 
                  ? IconButton(
                      icon: Icon(
                        state.showPassword
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: context.isDarkMode
                            ? Colors.white.withOpacity(0.75)
                            : Colors.black.withOpacity(0.75),
                      ),
                      onPressed: () => context
                          .read<PasswordVisibilityCubit>()
                          .toggleVisibility(),
                    )
                  : Icon(
                      icon,
                      color: context.isDarkMode
                          ? Colors.white.withOpacity(0.75)
                          : Colors.black.withOpacity(0.75),
                    ),
              border: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Color(0xff407BFF),
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Color(0xff407BFF),
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Color(0xff407BFF),
                ),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          );
        },
      ),
    );
  }
}
