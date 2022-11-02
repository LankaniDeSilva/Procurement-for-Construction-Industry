import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../components/custom_button.dart';
import '../../components/custom_text.dart';
import '../../components/custom_textfield.dart';
import '../../providers/auth/login_provider.dart';
import '../../util/app_colors.dart';
import '../../util/asset_constants.dart';
import '../../util/util_function.dart';

import 'forgot_password.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
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
                    text: "Login",
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
                  const SizedBox(height: 39.0),
                  CustomTextField(
                    hintText: "Email",
                    controller:
                        Provider.of<LoginProvider>(context).emailController,
                  ),
                  const SizedBox(height: 16.0),
                  CustomTextField(
                    isObscure: true,
                    hintText: "Password",
                    controller:
                        Provider.of<LoginProvider>(context).passwordController,
                  ),
                  const SizedBox(height: 16.0),
                  Align(
                    alignment: Alignment.centerRight,
                    child: InkWell(
                      onTap: () => UtilFunction.navigator(
                          context, const ForgotPassword()),
                      child: const CustomText(
                        text: "Forgot Your Password ?",
                        fontSize: 14.0,
                      ),
                    ),
                  ),
                  const SizedBox(height: 29.0),
                  Consumer<LoginProvider>(
                    builder: ((context, value, child) {
                      return CustomButton(
                        text: "Login",
                        isLoading: value.loading,
                        onTap: () async {
                          value.startLogin(context);
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
