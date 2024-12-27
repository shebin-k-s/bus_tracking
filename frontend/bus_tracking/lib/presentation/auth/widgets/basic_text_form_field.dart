import 'package:bus_tracking/common/helpers/is_dark_mode.dart';
import 'package:bus_tracking/core/configs/theme/app_colors.dart';
import 'package:bus_tracking/presentation/auth/cubit/password_visibility/password_visibility_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BasicTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final IconData? suffixIcon;
  final IconData? prefixIcon;
  final FormFieldValidator<String>? validator;
  final bool obscureText;
  final Color mainColor;
  final Color? iconColor;
  final double labelSize;

  const BasicTextFormField({
    super.key,
    required this.controller,
    required this.label,
    this.suffixIcon,
    this.prefixIcon,
    this.validator,
    this.obscureText = false,
    this.mainColor = AppColors.primary,
    this.labelSize = 14,
    this.iconColor,
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
            cursorColor: mainColor,
            style: TextStyle(
              color: iconColor
            ),
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.only(
                bottom: 20,
                left: 20,
              ),
              
              labelText: label,
              floatingLabelBehavior: FloatingLabelBehavior.auto,
              floatingLabelStyle: TextStyle(
                fontSize: labelSize,
                color: iconColor ??
                    (context.isDarkMode
                        ? Colors.white.withOpacity(0.75)
                        : Colors.black.withOpacity(0.75)),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.red.withOpacity(0.75),
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              errorStyle: TextStyle(color: Colors.red.withOpacity(0.75)),
              labelStyle: TextStyle(
                fontSize: labelSize,
                color: iconColor ??
                    (context.isDarkMode
                        ? Colors.white.withOpacity(0.75)
                        : Colors.black.withOpacity(0.75)),
              ),
              prefixIcon: prefixIcon == null
                  ? null
                  : Icon(
                      prefixIcon,
                      color: iconColor ??
                          (context.isDarkMode
                              ? Colors.white.withOpacity(0.75)
                              : Colors.black.withOpacity(0.75)),
                    ),
              suffixIcon: suffixIcon == null
                  ? null
                  : obscureText
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
                          suffixIcon,
                          color: context.isDarkMode
                              ? Colors.white.withOpacity(0.75)
                              : Colors.black.withOpacity(0.75),
                        ),
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  color: mainColor,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: mainColor,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: mainColor,
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
