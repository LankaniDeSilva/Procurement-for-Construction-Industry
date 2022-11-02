// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:logger/logger.dart';

import 'package:procurement_for_construction_industry/providers/Supplier/Item_provider.dart';
import 'package:procurement_for_construction_industry/providers/inventory/inventory_provider.dart';
import 'package:procurement_for_construction_industry/providers/site_manager/site_manager_provider.dart';
import 'package:procurement_for_construction_industry/screens/site_manager/site_manager_registration.dart';
import 'package:procurement_for_construction_industry/screens/staff/accountant/account_home.dart';
import 'package:procurement_for_construction_industry/screens/staff/manager/manager_home.dart';
import 'package:procurement_for_construction_industry/screens/staff/proc_depart/proc_dept_home.dart';
import 'package:procurement_for_construction_industry/screens/supplier/supplier_home.dart';
import 'package:procurement_for_construction_industry/util/util_function.dart';
import 'package:provider/provider.dart';

import '../../controllers/auth_controller.dart';

import '../../models/objects.dart';

import '../../screens/auth/signup.dart';

import '../order_provider/order_provider.dart';

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
          fetchUser(user.uid);
          if (user.email!.contains('@s.')) {
            UtilFunction.navigator(context, const SupplierHome());
          } else if (user.email!.contains('@p.')) {
            UtilFunction.navigator(context, const ProcDeptHome());
          } else if (user.email!.contains('@m.')) {
            UtilFunction.navigator(context, const ManagerHome());
          } else if (user.email!.contains('@a.')) {
            UtilFunction.navigator(context, const AccountStaff());
          } else if (user.email!.contains('@g')) {
            fetchUser(user.uid);

            await Provider.of<ItemProvider>(context, listen: false)
                .fetchItems();

            //----fetch created orders
            Provider.of<OrderProvider>(context, listen: false)
                .fetchOrders(user.uid);

            await Provider.of<SiteManagerProvider>(context, listen: false)
                .fetchSiteManager(user.uid, context);

            SiteManager manager =
                Provider.of<SiteManagerProvider>(context, listen: false)
                    .siteManager;

            await Provider.of<InventoryProvider>(context, listen: false)
                .fetchInventory(manager.location);

            UtilFunction.navigator(context, const SiteManagerRegistration());
          } else {
            UtilFunction.navigator(context, const SignUp());
          }

          Logger().i("User is signed in!");
        }
      });
    } catch (e) {
      Logger().e(e);
    }
  }
}
