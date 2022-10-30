import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:procurement_for_construction_industry/models/objects.dart';

import '../util/alert_helper.dart';

class InventoryCotroller {
  //-- create the user collection
  CollectionReference inventory =
      FirebaseFirestore.instance.collection('inventory');

  //------------save site manager in firestore cloud
  Future<void> saveInventoryData(BuildContext context, String location,
      String qty, String itemName) async {
    try {
      //-getting an unique document ID
      String docid = inventory.doc().id;

      //--saving data
      await inventory.doc(docid).set(
        {
          "location": location,
          "itemName": itemName,
          "qty": int.parse(qty),
          "id": docid,
          "date": DateTime.now(),
        },
        SetOptions(merge: true),
      );

      // ignore: use_build_context_synchronously
      AlertHelper.showAlert(
          context, "Inventory data Added", 'Success', DialogType.success);
    } catch (e) {
      Logger().e(e);
    }
  }

  // ----------fetch inventory
  Future<List<InventoryModel>> getInventory(String location) async {
    try {
      //----------query for fetching all the notices list
      QuerySnapshot snapshot =
          await inventory.where("location", isEqualTo: location).get();

      //----------notice list
      List<InventoryModel> inventoryList = [];

      //----------mapping fetch data to notice model and store in notice list
      for (var element in snapshot.docs) {
        //-----mapping to single notice model
        InventoryModel model =
            InventoryModel.fromJson(element.data() as Map<String, dynamic>);
        Logger().w(model);
        //-----adding to the list
        inventoryList.add(model);
      }

      return inventoryList;
    } catch (e) {
      Logger().e(e);
      return [];
    }
  }

  Future<void> updateInventory(
      String id, double size, BuildContext context) async {
    try {
      await inventory.doc(id).update({
        "size": size,
      }).then((_) {
        AlertHelper.showAlert(context, "Inventory Size Updated Successfully",
            "Inventory Size Update", DialogType.success);
      });
    } catch (e) {
      AlertHelper.showAlert(
          context, e.toString(), "Inventory Update", DialogType.error);
    }
  }
}
