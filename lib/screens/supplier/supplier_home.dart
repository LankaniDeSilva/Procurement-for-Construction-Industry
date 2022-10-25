import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:procurement_for_construction_industry/components/custom_button.dart';
import 'package:procurement_for_construction_industry/components/custom_text.dart';
import 'package:procurement_for_construction_industry/providers/site_manager/site_manager_provider.dart';
import 'package:procurement_for_construction_industry/screens/Supplier/Add%20Item.dart';
import 'package:procurement_for_construction_industry/screens/main/main_screen.dart';
import 'package:procurement_for_construction_industry/util/app_colors.dart';
import 'package:procurement_for_construction_industry/util/asset_constants.dart';
import 'package:procurement_for_construction_industry/util/util_function.dart';
import 'package:provider/provider.dart';
import 'package:procurement_for_construction_industry/components/custom_navigation.dart';
import 'package:procurement_for_construction_industry/components/custom_text.dart';
import '../../util/util_function.dart';
import '../../components/custom_textfield.dart';

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
      body: SingleChildScrollView(
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
    );
  }
}
