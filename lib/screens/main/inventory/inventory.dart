import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:procurement_for_construction_industry/models/objects.dart';
import 'package:procurement_for_construction_industry/providers/inventory/inventory_provider.dart';
import 'package:procurement_for_construction_industry/util/asset_constants.dart';

import 'package:provider/provider.dart';

import '../../../components/custom_button.dart';
import '../../../components/custom_text.dart';
import '../../../components/custom_textfield.dart';
import '../../../util/app_colors.dart';
import '../../../util/util_function.dart';

class Inventory extends StatefulWidget {
  const Inventory({Key? key}) : super(key: key);

  @override
  State<Inventory> createState() => _InventoryState();
}

class _InventoryState extends State<Inventory> {
  @override
  void initState() {
    super.initState();
  }

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
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 10.0),
                    const CustomText(
                      text: "Inventory",
                      fontSize: 25.0,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primaryColor,
                    ),
                    const SizedBox(height: 10.0),

                    const SizedBox(height: 20.0),
                    CustomTextField(
                      controller: Provider.of<InventoryProvider>(context)
                          .locationController,
                      hintText: "Location",
                    ),
                    const SizedBox(height: 8.0),
                    CustomTextField(
                      hintText: "ItemName",
                      controller: Provider.of<InventoryProvider>(context)
                          .itemController,
                    ),
                    const SizedBox(height: 16.0),
                    CustomTextField(
                      hintText: "Quantity",
                      controller:
                          Provider.of<InventoryProvider>(context).qtyController,
                    ),

                    const SizedBox(height: 29.0),
                    //-------loading icon shows instead of button
                    Consumer<InventoryProvider>(
                      builder: (context, value, child) {
                        return CustomButton(
                            isLoading: value.loading,
                            text: "Add to Inventory",
                            onTap: () async => value.saveInventory(context));
                      },
                    ),
                    Column(
                      children: [
                        const SizedBox(height: 20),
                        Container(
                          height: MediaQuery.of(context).size.height,
                          child: Consumer<InventoryProvider>(
                              builder: (context, value, child) {
                            return value.inventory.isEmpty
                                ? const CustomText(
                                    text: "Inventory is not available ",
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                    color: AppColors.kBlack,
                                  )
                                : ListView.builder(
                                    itemBuilder: (context, index) {
                                      return InventoryTile(
                                        model: value.inventory[index],
                                      );
                                    },
                                    itemCount: value.inventory.length,
                                  );
                          }),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class InventoryTile extends StatelessWidget {
  const InventoryTile({
    Key? key,
    required this.model,
  }) : super(key: key);

  final InventoryModel model;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8, bottom: 12),
      child: Container(
        height: 200,
        decoration: BoxDecoration(
          color: AppColors.kWhite,
          borderRadius: BorderRadius.circular(2.0),
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, 5),
              color: AppColors.kAsh.withOpacity(0.8),
              blurRadius: 5.0,
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 15, left: 14, right: 5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                text: 'Location:  ${model.location}',
                fontWeight: FontWeight.w700,
                fontSize: 16,
                color: AppColors.kBlack,
              ),
              const SizedBox(height: 5),
              CustomText(
                text: 'Item Name: ${model.itemName}',
                fontWeight: FontWeight.w700,
                fontSize: 16,
                color: AppColors.kBlack,
                textAlign: TextAlign.justify,
              ),
              const SizedBox(height: 5),
              CustomText(
                text: 'Units:  ${model.qty}',
                fontWeight: FontWeight.w700,
                fontSize: 16,
                color: AppColors.kBlack,
                textAlign: TextAlign.justify,
              ),
              CustomText(
                text: 'Date:  ${model.date.toString()}',
                fontWeight: FontWeight.w700,
                fontSize: 16,
                color: AppColors.kBlack,
                textAlign: TextAlign.justify,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
