// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:logger/logger.dart';
import 'package:procurement_for_construction_industry/models/objects.dart';
import 'package:procurement_for_construction_industry/screens/main/main_screen.dart';

import 'package:procurement_for_construction_industry/util/asset_constants.dart';
import 'package:procurement_for_construction_industry/util/util_function.dart';

import '../../util/alert_helper.dart';
import 'file_upload_controller.dart';

class SiteManagerController {
  //-- create the user collection
  CollectionReference sitemanager =
      FirebaseFirestore.instance.collection('sitemanager');

  //------------save site manager in firestore cloud
  Future<void> saveSiteManagerData(BuildContext context, String name,
      String phone, String location, String uid) async {
    try {
      //--saving data
      await sitemanager.doc(uid).set(
        {
          "uid": uid,
          "name": name,
          "phone": phone,
          "location": location,
          "img": AssetsContants.profileimgurl
        },
        SetOptions(merge: true),
      );

      AlertHelper.showAlert(context, "Site Manager Inserted Successfully",
          'Success', DialogType.success);
      UtilFunction.navigator(context, const MainScreen());
    } catch (e) {
      Logger().e(e);
    }
  }

  //----------upload and update user profile and return the image the url
  //-----------save Product function---
  Future<String> uploadandUpdateProfileImg(
    String uid,
    File img,
  ) async {
    try {
      //------uploading the image file to profile
      UploadTask? task = FileUploadController.uploadFile(img, 'profileImages');

      final snapshot = await task!.whenComplete(() {});

      //-------getting the download url
      final String downloadUrl = await snapshot.ref.getDownloadURL();

      //-saving the producy data in cloud firestore
      await sitemanager.doc(uid).update({
        "img": downloadUrl,
      });
      return downloadUrl;
    } catch (e) {
      Logger().e(e);
      // AlertHelper.showAlert(context, e.toString(), "Error", DialogType.ERROR);
      return '';
    }
  }

  //---------------fetch user data saved in cloud firestore
  Future<SiteManager?> fetchSiteManagerData(
      String uid, BuildContext context) async {
    try {
      //firebase Query that retrieve sitemanager data
      DocumentSnapshot snapshot = await sitemanager.doc(uid).get();
      Logger().i(snapshot.data());
      //------mapping fetch data to sitemanager model
      SiteManager model =
          SiteManager.fromJson(snapshot.data() as Map<String, dynamic>);

      return model;
    } catch (e) {
      Logger().e(e);
      return null;
    }
  }

  // Future<void> isSiteManagerRegistered(String uid, BuildContext context) async {
  //   try {
  //     final QuerySnapshot result =
  //         await sitemanager.where('uid', isEqualTo: uid).limit(1).get();
  //     final List<DocumentSnapshot> documents = result.docs;

  //     if (documents.isEmpty) {
  //       UtilFunction.navigator(context, const SiteManagerRegistration());
  //     } else {
  //       Provider.of<SiteManagerProvider>(context, listen: false)
  //           .fetchSiteManager(uid, context);
  //       UtilFunction.navigator(context, const MainScreen());
  //     }
  //   } catch (e) {
  //     Logger().e(e);
  //   }
  // }
}
