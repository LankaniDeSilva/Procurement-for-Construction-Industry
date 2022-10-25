import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:procurement_for_construction_industry/components/custom_text.dart';
import '../util/colors.dart';

class CustomNavigation extends StatelessWidget {
  const CustomNavigation({
    Key? key,
    required this.text,
    required this.onTap,
    this.isLoading = false,
  }) : super(key: key);

  final String text;
  final Function() onTap;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: isLoading,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          alignment: Alignment.center,
          width: 259.0,
          height: 50.0,
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 199, 240, 152),
            borderRadius: BorderRadius.circular(8.0),
          ),
          // -----loading icon inside the button
          child: isLoading
              ? const SpinKitRotatingCircle(
                  color: AppColors.kWhite,
                  size: 40.0,
                )
              : CustomText(
                  text: text,
                  fontWeight: FontWeight.w600,
                  // fontsize: 16,
                  color: AppColors.kWhite,
                ),
        ),
      ),
    );
  }
}
