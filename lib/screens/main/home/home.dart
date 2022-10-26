import 'package:flutter/material.dart';

import '../../../components/custom_text.dart';

import '../../../util/app_colors.dart';

import 'widgets/products_grid.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 28),
        child: Column(
          children: const [
            SizedBox(height: 25),
            Center(
              child: CustomText(
                text: "Items",
                fontSize: 26.0,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryColor,
              ),
            ),
            SizedBox(height: 41.0),
            ProductGrid()
          ],
        ),
      ),
    );
  }
}
