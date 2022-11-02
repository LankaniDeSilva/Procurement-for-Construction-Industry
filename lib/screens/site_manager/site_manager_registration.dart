import 'package:flutter/material.dart';
import 'package:procurement_for_construction_industry/components/custom_button.dart';
import 'package:procurement_for_construction_industry/components/custom_text.dart';
import 'package:procurement_for_construction_industry/providers/site_manager/site_manager_provider.dart';
import 'package:procurement_for_construction_industry/screens/main/main_screen.dart';
import 'package:procurement_for_construction_industry/util/app_colors.dart';
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
