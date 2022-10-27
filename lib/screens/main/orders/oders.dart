import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:procurement_for_construction_industry/providers/Supplier/Item_provider.dart';
import 'package:procurement_for_construction_industry/screens/main/orders/widgets/order_product_tile.dart';
import 'package:provider/provider.dart';

import '../../../components/custom_text.dart';
import '../../../providers/auth/user_provider.dart';
import '../../../providers/order_provider/order_provider.dart';
import '../../../util/app_colors.dart';

class Orders extends StatefulWidget {
  const Orders({Key? key}) : super(key: key);

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  @override
  Widget build(BuildContext context) {
    return FadeIn(
      child: Consumer<UserPrivider>(builder: (context, value, child) {
        return SafeArea(
          child: Column(
            children: [
              const Center(
                child: CustomText(
                  text: "Orders",
                  fontSize: 25.0,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primaryColor,
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: Consumer<OrderProvider>(
                  builder: (context, value, child) {
                    return value.orders.isEmpty
                        ? const Center(child: CustomText(text: "No orders"))
                        : ListView.separated(
                            itemBuilder: (context, index) {
                              return OrderProductTile(
                                index: index + 1,
                                model: value.orders[index],
                              );
                            },
                            separatorBuilder: (context, index) =>
                                const SizedBox(
                                  height: 20,
                                ),
                            itemCount: value.orders.length);
                  },
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
