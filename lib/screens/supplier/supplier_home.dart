import 'package:flutter/material.dart';
import 'package:procurement_for_construction_industry/components/custom_text.dart';

class SupplierHome extends StatefulWidget {
  const SupplierHome({Key? key}) : super(key: key);

  @override
  State<SupplierHome> createState() => _SupplierHomeState();
}

class _SupplierHomeState extends State<SupplierHome> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: CustomText(text: 'Supplier Home')),
    );
  }
}
