import 'package:flutter/material.dart';
import 'package:procurement_for_construction_industry/components/custom_text.dart';

import 'package:procurement_for_construction_industry/models/objects.dart';
import 'package:procurement_for_construction_industry/providers/inventory/inventory_provider.dart';
import 'package:provider/provider.dart';

import '../../../components/custom_button.dart';
import '../../../components/custom_textfield.dart';

class UpdateInventory extends StatefulWidget {
  const UpdateInventory({Key? key, required this.model}) : super(key: key);

  final InventoryModel model;

  @override
  State<UpdateInventory> createState() => _UpdateInventoryState();
}

class _UpdateInventoryState extends State<UpdateInventory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // body: SafeArea(
        //   child: SingleChildScrollView(
        //     child: Padding(
        //       padding: const EdgeInsets.symmetric(vertical: 100, horizontal: 10),
        //       child: Column(
        //         children: [
        //           CustomTextField(
        //             hintText: "Size",
        //             controller: Provider.of<InventoryProvider>(context)
        //                 .displaySize(widget.model.size),
        //             enabled: true,
        //             onChanged: (value) =>
        //                 Provider.of<InventoryProvider>(context, listen: false)
        //                     .updateSizeController
        //                     .text = value,
        //           ),
        //           const SizedBox(height: 18),
        //           Consumer<InventoryProvider>(
        //             builder: (context, value, child) {
        //               return CustomButton(
        //                   text: 'Update Inventory',
        //                   onTap: () => value.inventoryUpdate(
        //                         widget.model.id,
        //                         double.parse(value.updateSizeController.text),
        //                         widget.model.location,
        //                         context,
        //                       ));
        //             },
        //           ),
        //         ],
        //       ),
        //     ),
        //   ),
        // ),
        );
  }
}
