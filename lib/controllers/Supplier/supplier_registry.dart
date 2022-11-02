import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:procurement_for_construction_industry/models/objects.dart';
import '../../util/alert_helper.dart';

class SupplierController {
  //------Firebase auth instance
  final FirebaseAuth auth = FirebaseAuth.instance;

  //-- create the supplier collection
  CollectionReference supplier =
      FirebaseFirestore.instance.collection('suppliers');

  //---create instance of SupplierModel
  late SupplierModel supplierModel;

  //-----------save baby function---
  Future<void> saveSupplier(
    BuildContext context,
    String supplierName,
    String address,
    String contactnumber,
    String location,
    String uid,
  ) async {
    try {
      //-getting an unique document ID
      // String docid = supplier.doc().id;

      //-saving the supplier data in cloud firestore
      await supplier.doc(uid).set({
        "id": uid,
        "supplierName": supplierName,
        "address": address,
        "contactnumber": contactnumber,
        "location": location,
      });
      // ignore: use_build_context_synchronously
      AlertHelper.showAlert(context, "supplier Inserted Successfully",
          'Success', DialogType.success);
    } catch (e) {
      AlertHelper.showAlert(context, e.toString(), "Error", DialogType.error);
    }
  }
}
