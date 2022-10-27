import 'package:flutter/material.dart';
import 'package:procurement_for_construction_industry/providers/Supplier/Item_provider.dart';
import 'package:procurement_for_construction_industry/screens/main/product_details/widget/counter_section.dart';
import 'package:procurement_for_construction_industry/screens/main/product_details/widget/related_product_type.dart';
import 'package:provider/provider.dart';

import '../../../components/back_btn.dart';
import '../../../components/cart_button.dart';
import '../../../components/custom_button.dart';
import '../../../components/custom_text.dart';
import '../../../providers/cart/cart_provider.dart';
import '../../../util/app_colors.dart';
import '../../../util/size_config.dart';

class ItemDetails extends StatefulWidget {
  const ItemDetails({Key? key}) : super(key: key);

  @override
  State<ItemDetails> createState() => _ItemDetailsState();
}

class _ItemDetailsState extends State<ItemDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Consumer<ItemProvider>(
          builder: (context, value, child) {
            return SizedBox(
              height: SizeConfig.getHeight(context),
              width: SizeConfig.getWidth(context),
              child: Stack(
                children: [
                  Column(
                    children: [
                      Container(
                        width: SizeConfig.getWidth(context),
                        height: 286,
                        decoration: BoxDecoration(
                          color: AppColors.primaryColor,
                          image: DecorationImage(
                            image: NetworkImage(
                              value.itemModel.image,
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: const SafeArea(
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: BackBtn(),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Positioned(
                    top: 256,
                    child: Container(
                      width: SizeConfig.getWidth(context),
                      height: SizeConfig.getHeight(context),
                      padding: const EdgeInsets.fromLTRB(29, 34, 29, 0),
                      decoration: BoxDecoration(
                        color: AppColors.kWhite,
                        borderRadius: BorderRadius.circular(34),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomText(
                                text: value.itemModel.name,
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                              ),
                              const CounterSection(),
                            ],
                          ),
                          const SizedBox(height: 21),
                          CustomText(
                            text: 'Rs. ${value.itemModel.price}0',
                            fontSize: 14,
                          ),
                          const SizedBox(height: 28),

                          //-------related items section
                          CustomText(
                            text: 'Related items',
                            fontSize: 14,
                            color: AppColors.primaryColor.withOpacity(0.9),
                          ),
                          const SizedBox(height: 20),
                          SizedBox(
                            height: 85,
                            child: Consumer<ItemProvider>(
                                builder: ((context, value, child) {
                              return ListView.separated(
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) {
                                    return RelatedProductTile(
                                        itemModel: value.relatedItems[index]);
                                  },
                                  separatorBuilder: (context, index) =>
                                      const SizedBox(width: 21),
                                  itemCount: value.relatedItems.length);
                            })),
                          )
                        ],
                      ),
                    ),
                  ),
                  SafeArea(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Align(
                            alignment: Alignment.bottomCenter,
                            child: Consumer<ItemProvider>(
                              builder: (context, value, child) {
                                return CustomButton(
                                  text: "Add to Cart",
                                  onTap: () {
                                    Provider.of<CartProvider>(context,
                                            listen: false)
                                        .addToCart(value.itemModel, context);
                                  },
                                );
                              },
                            )),
                        const SizedBox(width: 10),
                        const CartButtonWidget()
                      ],
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
