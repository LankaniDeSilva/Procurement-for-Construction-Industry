import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
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

      //-saving the baby data in cloud firestore
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

  // //----------fetch supplier
  // Future<List<SupplierModel>> getsupplier() async {
  //   try {
  //     //----------query for fetching all the supplier list
  //     QuerySnapshot snapshot = await supplier.get();

  //     //----------baby list
  //     List<SupplierModel> supplierList = [];

  //     //----------mapping fetch data to baby model and store in baby list
  //     for (var element in snapshot.docs) {
  //       //-----mapping to single baby model
  //       SupplierModel model =
  //           SupplierModel.fromJson(element.data() as Map<String, dynamic>);

  //       //-----adding to the list
  //       supplierList.add(model);
  //     }

  //     return supplierList;
  //   } catch (e) {
  //     Logger().e(e);
  //     return [];
  //   }
  // }

  // Future<List<SupplierModel>> getData(String babyName) async {
  //   List<SupplierModel> dataList = [];
  //   try {
  //     await supplier
  //         .where('babyName', isEqualTo: babyName)
  //         .get()
  //         .then((QuerySnapshot querySnapshot) => {
  //               querySnapshot.docs.forEach((doc) {
  //                 dataList.add(doc.data());
  //               }),
  //             });
  //     return dataList;
  //   } catch (e) {
  //     Logger().e(e);
  //     return [];
  //   }
  // }
  // Future<List<SupplierModel>> getBabyByName(String name) async {
  //   List<SupplierModel> supplierList = [];

  //   try {
  //     FirebaseFirestore.instance
  //         .collection('supplier')
  //         .where('babyName', isEqualTo: name)
  //         .get()
  //         .then((QuerySnapshot querySnapshot) => {
  //               querySnapshot.docs.forEach((doc) {
  //                 supplierList.add(
  //                     SupplierModel.fromJson(doc.data() as Map<String, dynamic>));
  //               }),
  //             });

  //     return supplierList;
  //   } catch (e) {
  //     Logger().e(e);
  //     return [];
  //   }
  // }
}
