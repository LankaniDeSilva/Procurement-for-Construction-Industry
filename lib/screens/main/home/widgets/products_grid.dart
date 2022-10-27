import 'package:flutter/material.dart';
import 'package:procurement_for_construction_industry/models/objects.dart';
import 'package:procurement_for_construction_industry/providers/Supplier/Item_provider.dart';
import 'package:procurement_for_construction_industry/screens/main/product_details/product_details.dart';

import 'package:provider/provider.dart';

import '../../../../components/custom_text.dart';
import '../../../../providers/cart/cart_provider.dart';
import '../../../../util/app_colors.dart';
import '../../../../util/util_function.dart';

class ProductGrid extends StatelessWidget {
  const ProductGrid({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Consumer<ItemProvider>(
        builder: (context, value, child) {
          return value.loading
              ? const Center(child: CircularProgressIndicator())
              : GridView.builder(
                  itemCount: value.items.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 44.0,
                    crossAxisSpacing: 19.0,
                    childAspectRatio: 0.75,
                  ),
                  itemBuilder: (context, index) {
                    return ProductTile(
                      itemModel: value.items[index],
                    );
                  });
        },
      ),
    );
  }
}

class ProductTile extends StatelessWidget {
  const ProductTile({
    Key? key,
    required this.itemModel,
  }) : super(key: key);

  final ItemModel itemModel;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        //---set the selected product model before navigating to the product details screen
        Provider.of<ItemProvider>(context, listen: false).setItem(itemModel);

        // //------clear the product counter before go to the details screen
        Provider.of<CartProvider>(context, listen: false).clearCounter();

        // //----------navigate to product details screen
        UtilFunction.navigator(context, const ItemDetails());
      },
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.primaryColor,
          borderRadius: BorderRadius.circular(12.0),
          image: DecorationImage(
            image: NetworkImage(
              itemModel.image,
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: 38.0,
              padding: const EdgeInsets.symmetric(horizontal: 9.0),
              decoration: BoxDecoration(
                color: AppColors.primaryColor.withOpacity(0.7),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                    text: itemModel.name,
                    fontSize: 15,
                    color: AppColors.kWhite,
                    fontWeight: FontWeight.w500,
                  ),
                  CustomText(
                    text: "Rs.${itemModel.price}",
                    fontSize: 15,
                    color: AppColors.kBlack,
                    fontWeight: FontWeight.w500,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
