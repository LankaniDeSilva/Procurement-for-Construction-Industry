import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

import 'package:logger/logger.dart';
import 'package:procurement_for_construction_industry/controllers/Supplier/supplier_registry.dart';
import 'package:provider/provider.dart';

import '../../models/objects.dart';
import '../../util/alert_helper.dart';
import '../auth/user_provider.dart';

class SupplierProvider extends ChangeNotifier {
  //-------baby name text controller
  final _suppliernameController = TextEditingController();

  //----getter for baby name controller
  TextEditingController get supplierNameController => _suppliernameController;

  //-------phmDivision text controller
  final _supplieraddressController = TextEditingController();

  //----getter for phmDivision controller
  TextEditingController get supplierAddressController =>
      _supplieraddressController;

  //-------registration no text controller
  final _supplierContactNumberController = TextEditingController();

  //----getter for registration no controller
  TextEditingController get supplierContactNumberController =>
      _supplierContactNumberController;

  //-------registration no text controller
  final _spLoc = TextEditingController();

  //----getter for registration no controller
  TextEditingController get supplierLocationController => _spLoc;

  //---------loader state
  bool _isLoading = false;

  //----get loading state
  bool get loading => _isLoading;

  //-----change loading state
  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  // //------initialize the baby model list
  // List<SupplierModel> _clinics = [];

  // //-----getter for baby list
  // List<SupplierModel> get clinics => _clinics;

  // //------initialize the filter baby model list
  // List<SupplierModel> _filterClinic = [];

  // //-----getter for filter baby list
  // List<SupplierModel> get filterClinic => _filterClinic;

  // //------initialize the baby model list
  // List<SupplierModel> _searchResult = [];

  // //-----getter for baby list
  // List<SupplierModel> get searchResult => _searchResult;

  //-----baby controller instance
  // final SupplierController _SupplierController = SupplierController();

  //--validate text field function

  bool validateField(BuildContext context) {
    // first checking all the text filds are empty or not
    if (_suppliernameController.text.isEmpty ||
        _supplieraddressController.text.isEmpty ||
        _supplierContactNumberController.text.isEmpty ||
        _spLoc.text.isEmpty) {
      AlertHelper.showAlert(
        context,
        "Please fill all the fileds !",
        "Error",
        DialogType.ERROR,
      );
      return false;
    } else {
      return true;
    }
  }

  //---------start add baby process
  Future<void> addSupplier(BuildContext context) async {
    try {
      UserModel user =
          Provider.of<UserPrivider>(context, listen: false).userModel;
      //start the loader

      setLoading(true);

      // Logger().i("Validation success");
      await SupplierController().saveSupplier(
        context,
        _suppliernameController.text,
        _supplieraddressController.text,
        _supplierContactNumberController.text,
        _spLoc.text,
        user.uid,
      );

      //clear text field
      _suppliernameController.clear();
      _supplieraddressController.clear();
      _supplierContactNumberController.clear();
      _spLoc.clear();

      //stop the loader

      setLoading(false);
    } catch (e) {
      setLoading(false);
      Logger().e(e);
      AlertHelper.showAlert(context, e.toString(), 'Error', DialogType.ERROR);
    }
  }

  // //-----fetch baby function
  // Future<void> fetchclinics() async {
  //   try {
  //     //------start the loader
  //     setLoading(true);

  //     //----start fetching clinics
  //     _clinics = await _SupplierController.getclinic();
  //     Logger().w(_clinics.length);

  //     notifyListeners();

  //     //-----stop loading
  //     setLoading(false);
  //   } catch (e) {
  //     Logger().e(e);
  //     setLoading(false);
  //   }
  // }

  // Future<List<SupplierModel>> onSearchTextChanged(String name) async {
  //   // _searchResult.clear();
  //   // if (text.isEmpty) {
  //   //   return;
  //   // }

  //   // _clinics.forEach((baby) {
  //   //   if (baby.babyName.contains(text)) _searchResult.add(baby);
  //   // });
  //   try {
  //     _searchResult.clear();
  //     _filterClinic = await SupplierController().getBabyByName(name);
  //     return _filterClinic;
  //   } catch (e) {
  //     Logger().e(e);
  //     return [];
  //   }
  // }
}
