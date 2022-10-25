import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:procurement_for_construction_industry/models/objects.dart';
import '../../util/alert_helper.dart';

class ItemController {
  //------Firebase auth instance
  final FirebaseAuth auth = FirebaseAuth.instance;

  //-- create the item collection
  CollectionReference item = FirebaseFirestore.instance.collection('items');

  //---create instance of itemModel
  late ItemModel itemModel;

  //-----------save baby function---
  Future<void> saveItem(
    BuildContext context,
    String itemID,
    String itemName,
    String itemPrice,
    String itemQTY,
  ) async {
    try {
      //-getting an unique document ID
      String docid = item.doc().id;

      //-saving the baby data in cloud firestore
      await item.doc(docid).set({
        "id": docid,
        "itemID": itemID,
        "itemName": itemName,
        "itemPrice": itemPrice,
        "itemQTY": itemQTY,
      });
      // ignore: use_build_context_synchronously
      AlertHelper.showAlert(
          context, "item Inserted Successfully", 'Success', DialogType.SUCCES);
    } catch (e) {
      AlertHelper.showAlert(context, e.toString(), "Error", DialogType.ERROR);
    }
  }

  // //----------fetch item
  // Future<List<itemModel>> getitem() async {
  //   try {
  //     //----------query for fetching all the item list
  //     QuerySnapshot snapshot = await item.get();

  //     //----------baby list
  //     List<itemModel> itemList = [];

  //     //----------mapping fetch data to baby model and store in baby list
  //     for (var element in snapshot.docs) {
  //       //-----mapping to single baby model
  //       itemModel model =
  //           itemModel.fromJson(element.data() as Map<String, dynamic>);

  //       //-----adding to the list
  //       itemList.add(model);
  //     }

  //     return itemList;
  //   } catch (e) {
  //     Logger().e(e);
  //     return [];
  //   }
  // }

  // Future<List<itemModel>> getData(String babyName) async {
  //   List<itemModel> dataList = [];
  //   try {
  //     await item
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
  // Future<List<itemModel>> getBabyByName(String name) async {
  //   List<itemModel> itemList = [];

  //   try {
  //     FirebaseFirestore.instance
  //         .collection('item')
  //         .where('babyName', isEqualTo: name)
  //         .get()
  //         .then((QuerySnapshot querySnapshot) => {
  //               querySnapshot.docs.forEach((doc) {
  //                 itemList.add(
  //                     itemModel.fromJson(doc.data() as Map<String, dynamic>));
  //               }),
  //             });

  //     return itemList;
  //   } catch (e) {
  //     Logger().e(e);
  //     return [];
  //   }
  // }
}