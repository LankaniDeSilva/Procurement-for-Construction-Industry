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
}
