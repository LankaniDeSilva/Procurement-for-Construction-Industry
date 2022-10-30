import 'dart:io';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:procurement_for_construction_industry/models/objects.dart';
import 'package:procurement_for_construction_industry/util/asset_constants.dart';
import '../../util/alert_helper.dart';
import '../site_manager/file_upload_controller.dart';

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
    File img,
  ) async {
    try {
      //------uploading the image file
      UploadTask? task = FileUploadController.uploadFile(img, 'itemImages');

      final snapshot = await task!.whenComplete(() {});

      //-------getting the download url
      final String downloadUrl = await snapshot.ref.getDownloadURL();

      //-getting an unique document ID
      String docid = item.doc().id;

      //-saving the baby data in cloud firestore
      await item.doc(docid).set({
        "id": docid,
        "itemID": itemID,
        "itemName": itemName,
        "itemPrice": double.parse(itemPrice),
        "itemQTY": int.parse(itemQTY),
        "image": downloadUrl,
      });
      // ignore: use_build_context_synchronously
      AlertHelper.showAlert(
          context, "item Inserted Successfully", 'Success', DialogType.success);
    } catch (e) {
      AlertHelper.showAlert(context, e.toString(), "Error", DialogType.error);
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

  //----------fetch items
  Future<List<ItemModel>> getItems() async {
    try {
      //----------query for fetching all the items list
      QuerySnapshot snapshot = await item.get();

      //----------product list
      List<ItemModel> itemList = [];

      //----------mapping fetch data to item model and store in item list
      for (var element in snapshot.docs) {
        //-----mapping to single item model
        itemModel = ItemModel.fromJson(element.data() as Map<String, dynamic>);

        if (itemModel.image.isEmpty) {
          itemModel.image = AssetsContants.dummyItem;
        }
        //-----adding to the list
        itemList.add(itemModel);
      }

      return itemList;
    } catch (e) {
      Logger().e(e);
      return [];
    }
  }
}
