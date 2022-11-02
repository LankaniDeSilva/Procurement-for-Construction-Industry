import 'package:flutter/material.dart';
import 'package:procurement_for_construction_industry/providers/order_provider/order_provider.dart';
import 'package:provider/provider.dart';

import '../../../../components/custom_text.dart';
import '../../../../models/objects.dart';
import '../../../../util/app_colors.dart';
import '../../../../util/size_config.dart';
import '../../../../util/util_function.dart';
import '../../product_details/product_details.dart';

class OrderProductTile extends StatelessWidget {
  const OrderProductTile({
    Key? key,
    required this.index,
    required this.model,
  }) : super(key: key);

  final int index;
  final OrderModel model;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        //----------navigate to product details screen
        UtilFunction.navigator(context, const ItemDetails());
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 30),
        height: 90,
        padding: const EdgeInsets.all(10),
        width: SizeConfig.getWidth(context),
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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.network(
                    model.items.first.model.image,
                    width: 70,
                    height: 70,
                    fit: BoxFit.fill,
                  ),
                ),
                const SizedBox(width: 16),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: 'Order No $index',
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                    const SizedBox(height: 10),
                    CustomText(
                      text:
                          "${model.items.first.model.name} x ${model.items.first.model.qty}",
                      fontSize: 15,
                    ),
                  ],
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: CustomText(
                    text: model.orderState,
                    color: AppColors.kWhite,
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                CustomText(
                  text: 'Total Rs.${model.total}0',
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
                InkWell(
                  onTap: () =>
                      Provider.of<OrderProvider>(context, listen: false)
                          .removeOrder(model.id, context, model.userModel.uid),
                  child: const Icon(
                    Icons.close,
                    color: AppColors.kRed,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
