import 'package:flutter/material.dart';

import 'package:procurement_for_construction_industry/providers/auth/forgot_provider.dart';
import 'package:provider/provider.dart';

import '../../components/custom_button.dart';
import '../../components/custom_text.dart';
import '../../components/custom_textfield.dart';

import '../../util/app_colors.dart';
import '../../util/asset_constants.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          width: size.width,
          child: SafeArea(
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 52.0),
                  const CustomText(
                    text: "Forgot Password",
                    fontSize: 25.0,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primaryColor,
                  ),
                  const SizedBox(height: 41),
                  Image.asset(
                    AssetsContants.logo,
                    width: 202.26,
                    height: 138.0,
                  ),
                  const SizedBox(height: 100.0),
                  const CustomText(
                    text:
                        "Please, enter your email address. You will receive a link to create a new password via email.",
                    fontSize: 14.0,
                  ),
                  const SizedBox(height: 16.0),
                  CustomTextField(
                    hintText: "Email",
                    controller:
                        Provider.of<ForgotProvider>(context).emailController,
                  ),
                  const SizedBox(height: 16.0),
                  Consumer<ForgotProvider>(
                    builder: ((context, value, child) {
                      return CustomButton(
                        text: "Send Reset Email",
                        isLoading: value.loading,
                        onTap: () async {
                          value.changePassword(context);
                        },
                      );
                    }),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
