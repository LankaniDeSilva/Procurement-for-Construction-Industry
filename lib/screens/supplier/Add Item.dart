import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:procurement_for_construction_industry/components/custom_button.dart';
import 'package:procurement_for_construction_industry/components/custom_text.dart';
import 'package:procurement_for_construction_industry/providers/Supplier/Item_provider.dart';
import 'package:procurement_for_construction_industry/screens/main/main_screen.dart';
import 'package:procurement_for_construction_industry/util/app_colors.dart';
import 'package:procurement_for_construction_industry/util/asset_constants.dart';
import 'package:procurement_for_construction_industry/util/util_function.dart';
import 'package:provider/provider.dart';

import '../../components/custom_textfield.dart';

class ItemAdd extends StatefulWidget {
  const ItemAdd({Key? key}) : super(key: key);

  @override
  State<ItemAdd> createState() => _ItemAddState();
}

class _ItemAddState extends State<ItemAdd> {
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
                      text: "Add Item",
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
                          controller: Provider.of<ItemProvider>(context)
                              .itemIDController,
                          hintText: "Item ID",
                        ),
                        const SizedBox(height: 20.0),
                        CustomTextField(
                          controller: Provider.of<ItemProvider>(context)
                              .itemNameController,
                          hintText: "item Name",
                        ),
                        const SizedBox(height: 20.0),
                        CustomTextField(
                          controller: Provider.of<ItemProvider>(context)
                              .itemPriceController,
                          hintText: "price",
                        ),
                        const SizedBox(height: 20.0),
                        CustomTextField(
                          controller: Provider.of<ItemProvider>(context)
                              .itemQTYController,
                          hintText: "Quentity",
                        ),
                        const SizedBox(height: 20.0),
                        Consumer<ItemProvider>(
                          builder: (context, value, child) {
                            return CustomButton(
                                text: "Add Item",
                                onTap: () {
                                  value.addItem(context);
                                });
                          },
                        ),
                        const SizedBox(height: 20.0),
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
