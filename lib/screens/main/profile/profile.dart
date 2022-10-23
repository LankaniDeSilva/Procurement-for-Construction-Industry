import 'package:animate_do/animate_do.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:procurement_for_construction_industry/providers/site_manager/site_manager_provider.dart';

import 'package:provider/provider.dart';
import '../../../components/custom_button.dart';
import '../../../components/custom_text.dart';
import '../../../controllers/auth_controller.dart';
import '../../../providers/auth/user_provider.dart';
import '../../../util/app_colors.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: FadeIn(
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  const Center(
                    child: Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: CustomText(
                        text: "Profile",
                        fontSize: 25.0,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ),
                  const SizedBox(height: 122),
                  Consumer<SiteManagerProvider>(
                    builder: (context, value, child) {
                      return value.loading
                          ? const SpinKitRotatingCircle(
                              color: Colors.white,
                              size: 40.0,
                            )
                          : InkWell(
                              onTap: () => value.selectImageAndUpload(),
                              child: Image.network(
                                value.siteManager.img,
                                width: 200,
                                height: 200,
                                fit: BoxFit.cover,
                              ),
                            );
                    },
                  ),
                  const SizedBox(height: 30),
                  Consumer<UserPrivider>(
                    builder: (context, value, child) {
                      return Column(
                        children: [
                          CustomText(
                            text: value.userModel.name,
                            fontSize: 18.0,
                            color: AppColors.kBlack,
                          ),
                          CustomText(
                            text: value.userModel.email,
                            fontSize: 18.0,
                            color: AppColors.kBlack,
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
              Column(
                children: [
                  const SizedBox(height: 8),
                  CustomButton(
                    text: "Logout",
                    onTap: () {
                      AuthController().signoutUser();
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
