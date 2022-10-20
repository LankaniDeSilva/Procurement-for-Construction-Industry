import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:procurement_for_construction_industry/screens/auth/login.dart';
import 'package:procurement_for_construction_industry/util/util_function.dart';

import '../models/objects.dart';
import '../util/alert_helper.dart';

class AuthController {
  //------Firebase auth instance
  final FirebaseAuth auth = FirebaseAuth.instance;

  //-- create the user collection
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  //-----------signup function---
  Future<void> registerUser(
    BuildContext context,
    String email,
    String password,
    String name,
  ) async {
    try {
      //-------send email and password to the firebase and create a user
      await auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) async {
        //-------check if the user credentials object is not null
        Logger().w(value.user);
        if (value.user != null) {
          //------save other user data in cloud firestore
          await saveUserData(value.user!.uid, name, email);
          //--------if user created successfully show an alert
          // ignore: use_build_context_synchronously
          AlertHelper.showAlert(
            context,
            "User created successfully",
            "Success",
            DialogType.success,
          );
        }
      });
    } on FirebaseAuthException catch (e) {
      AlertHelper.showAlert(
        context,
        e.code,
        "Error",
        DialogType.error,
      );
    } catch (e) {
      AlertHelper.showAlert(
        context,
        e.toString(),
        "Error",
        DialogType.error,
      );
    }
  }

  //------------Sign up user in firestore cloud
  Future<void> saveUserData(String uid, String name, String email) async {
    return users
        .doc(uid)
        .set(
          {"name": name, "email": email, "uid": uid},
          SetOptions(merge: true),
        )
        .then((value) => Logger().i("User Added"))
        .catchError((error) => Logger().e("Failed to add user: $error"));
  }

  //--------sign out function
  Future<void> signoutUser() async {
    await auth.signOut();
  }

  //-----------signin function---
  Future<void> signinUser(
    BuildContext context,
    String email,
    String password,
  ) async {
    try {
      //-------send email and password to the firebase and create a user
      final credentials = await auth.signInWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      AlertHelper.showAlert(
        context,
        e.code,
        "Error",
        DialogType.error,
      );
    } catch (e) {
      AlertHelper.showAlert(
        context,
        e.toString(),
        "Error",
        DialogType.error,
      );
    }
  }

  //send password reset email
  Future<void> sendPasswordResetEmail(
      BuildContext context, String email) async {
    await auth.sendPasswordResetEmail(email: email).then((value) async {
      //show dialog when the email is sent
      await AlertHelper.showAlert(
          context, "Please check your email", "Email sent", DialogType.success);
      // ignore: use_build_context_synchronously
      UtilFunction.navigator(context, const Login());
    });
  }
}
