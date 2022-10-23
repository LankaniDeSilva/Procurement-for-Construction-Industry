import 'package:flutter/material.dart';

import '../util/app_colors.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    Key? key,
    required this.hintText,
    this.isObscure = false,
    this.controller,
    this.enabled = false,
    this.onChanged,
  }) : super(key: key);

  final String hintText;
  final bool isObscure;
  final TextEditingController? controller;
  final bool enabled;
  final Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.kWhite,
        borderRadius: BorderRadius.circular(2.0),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 5),
            color: AppColors.kAsh.withOpacity(0.8),
            blurRadius: 5.0,
            // spreadRadius: 2.0,
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        enabled: enabled,
        obscureText: isObscure,
        onChanged: onChanged,
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          hintText: hintText,
          hintStyle: const TextStyle(color: AppColors.kAsh),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(2),
            borderSide: const BorderSide(color: AppColors.kWhite),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(2),
            borderSide: const BorderSide(color: AppColors.kRed),
          ),
        ),
      ),
    );
  }
}
