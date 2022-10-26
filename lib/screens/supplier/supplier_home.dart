import 'package:flutter/material.dart';
import 'package:procurement_for_construction_industry/components/custom_text.dart';
import 'package:procurement_for_construction_industry/controllers/auth_controller.dart';

class SupplierHome extends StatefulWidget {
  const SupplierHome({Key? key}) : super(key: key);

  @override
  State<SupplierHome> createState() => _SupplierHomeState();
}

class _SupplierHomeState extends State<SupplierHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              CustomText(text: 'Supplier Home'),
              InkWell(
                  onTap: (() => AuthController().signoutUser()),
                  child: Icon(Icons.logout))
            ],
          ),
        ),
      ),
    );
  }
}
