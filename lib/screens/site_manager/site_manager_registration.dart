import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:procurement_for_construction_industry/components/custom_button.dart';
import 'package:procurement_for_construction_industry/components/custom_text.dart';
import 'package:procurement_for_construction_industry/providers/site_manager/site_manager_provider.dart';
import 'package:procurement_for_construction_industry/screens/main/main_screen.dart';
import 'package:procurement_for_construction_industry/util/app_colors.dart';
import 'package:procurement_for_construction_industry/util/asset_constants.dart';
import 'package:procurement_for_construction_industry/util/util_function.dart';
import 'package:provider/provider.dart';

import '../../components/custom_textfield.dart';

class SiteManagerRegistration extends StatefulWidget {
  const SiteManagerRegistration({Key? key}) : super(key: key);

  @override
  State<SiteManagerRegistration> createState() =>
      _SiteManagerRegistrationState();
}

class _SiteManagerRegistrationState extends State<SiteManagerRegistration> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: size.width,
          child: SafeArea(
            child: Center(
              child: Column(
                children: [
                  Container(
                    height: size.height / 5,
                    width: size.width,
                    decoration: const BoxDecoration(
                      color: AppColors.primaryColor,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(100),
                        bottomRight: Radius.circular(100),
                      ),
                    ),
                    child: const CustomText(
                      text: "Site Manager \nRegistration",
                      textAlign: TextAlign.center,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      children: [
                        const SizedBox(height: 20.0),
                        CustomTextField(
                          controller: Provider.of<SiteManagerProvider>(context)
                              .sitemanagerNameController,
                          hintText: "Site Manager Name",
                        ),
                        const SizedBox(height: 20.0),
                        CustomTextField(
                          controller: Provider.of<SiteManagerProvider>(context)
                              .phoneController,
                          hintText: "Contact Number",
                        ),
                        const SizedBox(height: 20.0),
                        CustomTextField(
                          controller: Provider.of<SiteManagerProvider>(context)
                              .locationController,
                          hintText: "Site Location",
                        ),
                        const SizedBox(height: 20.0),
                        Consumer<SiteManagerProvider>(
                          builder: (context, value, child) {
                            return CustomButton(
                                text: "Register",
                                onTap: () {
                                  value.startSiteManagerRegistering(context);
                                });
                          },
                        ),
                        const SizedBox(height: 20.0),
                        InkWell(
                            onTap: () {
                              UtilFunction.navigator(
                                  context, const MainScreen());
                            },
                            child:
                                const CustomText(text: "Already Registered")),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class DialogBoxContainer extends StatelessWidget {
  const DialogBoxContainer({
    Key? key,
    required this.onTap,
  }) : super(key: key);

  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return ElasticIn(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.center,
            clipBehavior: Clip.none,
            children: [
              Container(
                width: 300,
                height: 333,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: AppColors.kWhite,
                  boxShadow: [
                    BoxShadow(
                      offset: const Offset(0, 10),
                      blurRadius: 20,
                      color: AppColors.kAsh.withOpacity(0.4),
                    )
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // SvgPicture.asset(AssetsContants.dialogIcon),
                    const SizedBox(height: 23),
                    const CustomText(
                      textAlign: TextAlign.center,
                      text: 'Thanks for Buying\nFrom Us!',
                      color: AppColors.primaryColor,
                      fontSize: 20,
                    )
                  ],
                ),
              ),
              Positioned(
                bottom: -20,
                child: CustomButton(text: 'See Order', onTap: onTap),
              )
            ],
          ),
        ],
      ),
    );
  }
}
