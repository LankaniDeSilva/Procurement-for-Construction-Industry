import 'package:flutter/material.dart';
import 'package:procurement_for_construction_industry/models/objects.dart';
import 'package:procurement_for_construction_industry/providers/Supplier/Item_provider.dart';
import 'package:procurement_for_construction_industry/providers/cart/cart_provider.dart';
import 'package:procurement_for_construction_industry/util/colors.dart';
import 'package:provider/provider.dart';

import '../../../../components/custom_text.dart';

class RelatedProductTile extends StatelessWidget {
  const RelatedProductTile({
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

        //------clear the product counter before go to the details screen
        // Provider.of<CartProvider>(context, listen: false).clearCart();
      },
      child: Container(
        width: 100,
        height: 83,
        decoration: BoxDecoration(
          color: AppColors.primaryColor,
          borderRadius: BorderRadius.circular(12.0),
          image: DecorationImage(
            image: NetworkImage(
              // "https://media.istockphoto.com/vectors/pumpkin-flat-design-vegetable-icon-vector-id1017915018?k=20&m=1017915018&s=612x612&w=0&h=P9swKR83-uYkc3j5uGVboTH9Q7mouaAhm9FbJZMnmGc="
              itemModel.image,
            ),
            fit: BoxFit.fill,
          ),
        ),
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              height: 24.0,
              padding: const EdgeInsets.symmetric(horizontal: 3),
              decoration: BoxDecoration(
                color: AppColors.kWhite.withOpacity(0.7),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 30,
                    child: CustomText(
                      text: itemModel.name,
                      fontSize: 11,
                      // color: AppColors.kWhite,
                      fontWeight: FontWeight.w600,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  CustomText(
                    text: "Rs.${itemModel.price}0",
                    fontSize: 10,
                    color: AppColors.kBlack,
                    fontWeight: FontWeight.w500,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
