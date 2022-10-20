import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../components/custom_button.dart';
import '../../components/custom_text.dart';
import '../../components/custom_textfield.dart';
import '../../providers/auth/signup_provider.dart';
import '../../util/app_colors.dart';
import '../../util/asset_constants.dart';
import '../../util/util_function.dart';
import 'login.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
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
                    text: "SignUp",
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
                  const SizedBox(height: 20.0),
                  CustomTextField(
                    controller:
                        Provider.of<SignupProvider>(context).nameController,
                    hintText: "Name",
                  ),
                  const SizedBox(height: 8.0),
                  CustomTextField(
                    hintText: "Email",
                    controller:
                        Provider.of<SignupProvider>(context).emailController,
                  ),
                  const SizedBox(height: 16.0),
                  CustomTextField(
                    isObscure: true,
                    hintText: "Password",
                    controller:
                        Provider.of<SignupProvider>(context).passwordController,
                  ),

                  const SizedBox(height: 29.0),
                  //-------loading icon shows instead of button
                  Consumer<SignupProvider>(
                    builder: (context, value, child) {
                      return CustomButton(
                          isLoading: value.loading,
                          text: "SignUp",
                          onTap: () async => value.startSignup(context));
                    },
                  ),

                  const SizedBox(height: 16.0),
                  Align(
                    alignment: Alignment.center,
                    child: InkWell(
                      onTap: () =>
                          UtilFunction.navigator(context, const Login()),
                      child: const CustomText(
                        text: "Already have an account?",
                        fontSize: 16.0,
                      ),
                    ),
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
