import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:logger/logger.dart';
import 'package:procurement_for_construction_industry/controllers/site_manager/site_manager_controller.dart';
import 'package:procurement_for_construction_industry/providers/site_manager/site_manager_provider.dart';
import 'package:procurement_for_construction_industry/screens/main/home/home.dart';
import 'package:procurement_for_construction_industry/screens/main/main_screen.dart';
import 'package:procurement_for_construction_industry/screens/site_manager/site_manager_registration.dart';
import 'package:procurement_for_construction_industry/util/util_function.dart';
import 'package:provider/provider.dart';

import '../../controllers/auth_controller.dart';
import '../../models/objects.dart';

import '../../screens/auth/signup.dart';

class UserPrivider extends ChangeNotifier {
  //---------User Model
  late UserModel _userModel;

  //--------get user model
  UserModel get userModel => _userModel;

  //---------loader state
  bool _isLoading = false;

  //----get loading state
  bool get loading => _isLoading;

  //-----change loading state
  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  //------------fetch single user
  Future<void> fetchUser(String id) async {
    try {
      //-start the loader
      setLoading(true);
      await AuthController().fetchUserData(id).then((value) {
        if (value != null) {
          Logger().w(value);

          _userModel = value;
          notifyListeners();
          setLoading(false);
        }
      });
    } catch (e) {
      Logger().e(e);
    }
  }

  //----------Initialize and check whether the user signed in or not
  Future<void> initializeUser(BuildContext context) async {
    try {
      FirebaseAuth.instance.authStateChanges().listen((User? user) async {
        if (user == null) {
          Logger().i("User signed out !");

          UtilFunction.navigator(context, const SignUp());
        } else {
          Logger().i("User is signed in!");
          fetchUser(user.uid);
          Provider.of<SiteManagerProvider>(context, listen: false)
              .fetchSiteManager(user.uid, context);
          UtilFunction.navigator(context, const SiteManagerRegistration());
        }
      });
    } catch (e) {
      Logger().e(e);
    }
  }
}
