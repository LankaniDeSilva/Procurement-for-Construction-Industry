import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../components/custom_text.dart';
import '../../../../providers/cart/cart_provider.dart';
import '../../../../util/app_colors.dart';

class CounterSection extends StatelessWidget {
  const CounterSection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 3),
      decoration: BoxDecoration(
        border: Border.all(
          color: AppColors.kAsh,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Consumer<CartProvider>(
        builder: (context, value, child) {
          return Row(
            children: [
              InkWell(
                  onTap: () => value.increaseCounter(),
                  child: const Icon(Icons.add)),
              const SizedBox(width: 15),
              CustomText(
                text: value.counter.toString(),
                fontSize: 14,
              ),
              const SizedBox(width: 15),
              InkWell(
                  onTap: () => value.decreaseCounter(),
                  child: const Icon(Icons.remove)),
            ],
          );
        },
      ),
    );
  }
}
