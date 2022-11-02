import 'package:flutter/material.dart';
import 'package:procurement_for_construction_industry/controllers/auth_controller.dart';
import 'package:procurement_for_construction_industry/screens/Supplier/Add%20Item.dart';
import 'package:procurement_for_construction_industry/util/util_function.dart';
import 'package:procurement_for_construction_industry/components/custom_navigation.dart';
import '../../util/util_function.dart';

import 'package:procurement_for_construction_industry/screens/Supplier/supplier_register.dart';

class SupplierHome extends StatefulWidget {
  const SupplierHome({Key? key}) : super(key: key);

  @override
  State<SupplierHome> createState() => _SupplierHomeState();
}

class _SupplierHomeState extends State<SupplierHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          InkWell(
              onTap: () => AuthController().signoutUser(),
              child: const Icon(Icons.logout)),
        ],
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Center(
            child: Column(
              children: <Widget>[
                CustomNavigation(
                  text: 'Clinic schedule',
                  onTap: () =>
                      UtilFunction.navigator(context, const SupplierRegister()),
                ),
                Padding(padding: const EdgeInsets.all(10.0)),
                CustomNavigation(
                  text: 'Item Add',
                  onTap: () => UtilFunction.navigator(context, const ItemAdd()),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
