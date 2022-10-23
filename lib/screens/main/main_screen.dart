import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:procurement_for_construction_industry/screens/main/inventory/inventory.dart';
import 'package:procurement_for_construction_industry/screens/main/order/orders.dart';
import 'package:procurement_for_construction_industry/util/asset_constants.dart';

import '../../components/custom_text.dart';
import '../../util/app_colors.dart';
import 'home/home.dart';
import 'profile/profile.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  void initState() {
    // Logger().w(widget.uid);
    _screens.addAll({
      const HomeScreen(),
      const Inventory(),
      const OrderScreen(),
      const Profile(),
    });
    super.initState();
  }

  //List to store bottom navigation screens
  final List<Widget> _screens = [];

  int index = 0;

  //onTap function
  void onItemTap(int i) {
    setState(() {
      index = i;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const CustomText(
            text: 'Pahasara Constructions',
            color: AppColors.kWhite,
            fontSize: 20,
            fontWeight: FontWeight.bold),
        backgroundColor: AppColors.primaryColor,
      ),
      body: _screens[index],
      bottomNavigationBar: SizedBox(
        height: 83.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            InkWell(
              child: SvgPicture.asset(
                AssetsContants.homeIcon,
                color: index == 0 ? AppColors.primaryColor : AppColors.kAsh,
              ),
              onTap: () => onItemTap(0),
            ),
            InkWell(
              child: SvgPicture.asset(
                AssetsContants.orderIcon,
                color: index == 1 ? AppColors.primaryColor : AppColors.kAsh,
              ),
              onTap: () => onItemTap(1),
            ),
            InkWell(
              child: SvgPicture.asset(
                AssetsContants.inventoryIcon,
                color: index == 2 ? AppColors.primaryColor : AppColors.kAsh,
              ),
              onTap: () => onItemTap(2),
            ),
            InkWell(
              child: SvgPicture.asset(
                AssetsContants.profileIcon,
                color: index == 3 ? AppColors.primaryColor : AppColors.kAsh,
              ),
              onTap: () => onItemTap(3),
            ),
          ],
        ),
      ),
    );
  }
}
