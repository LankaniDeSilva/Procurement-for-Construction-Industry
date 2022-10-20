import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../components/custom_text.dart';
import '../../providers/auth/user_provider.dart';
import '../../util/app_colors.dart';
import '../../util/asset_constants.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<UserPrivider>(context, listen: false).initializeUser(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FadeInDown(
                child: Image.asset(
              AssetsContants.logo,
              width: 200,
              height: 200,
            )),
            const SizedBox(height: 40.0),
            FadeInUp(
              child: const CustomText(
                text: 'Pahasara \nConstructions',
                textAlign: TextAlign.center,
                fontSize: 30.0,
                fontWeight: FontWeight.w500,
                color: AppColors.primaryColor,
              ),
            )
          ],
        ),
      ),
    );
  }
}
