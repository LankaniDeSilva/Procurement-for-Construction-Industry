import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:procurement_for_construction_industry/controllers/inventory_controller.dart';
import 'package:procurement_for_construction_industry/models/objects.dart';
import 'package:provider/provider.dart';

import '../../util/alert_helper.dart';
import '../auth/user_provider.dart';
import '../site_manager/site_manager_provider.dart';

class InventoryProvider extends ChangeNotifier {
  //-------location text controller
  final _locationController = TextEditingController();

  //----getter for location controller
  TextEditingController get locationController => _locationController;

  //-------size text controller
  TextEditingController _qtyController = TextEditingController();

  //----getter for size controller
  TextEditingController get qtyController => _qtyController;

  //-------site name text controller
  final _itemController = TextEditingController();

  //----getter for site name controller
  TextEditingController get itemController => _itemController;

  //-------update size text controller
  TextEditingController _updateSizeController = TextEditingController();

  //----getter for location controller
  TextEditingController get updateSizeController => _updateSizeController;

  //---------loader state
  bool _isLoading = false;

  //----get loading state
  bool get loading => _isLoading;

  //-----change loading state
  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  //------initialize the baby model list
  List<InventoryModel> _inventory = [];

  //-----getter for baby list
  List<InventoryModel> get inventory => _inventory;

  //--validate text field function

  bool validateField(BuildContext context) {
    // first checking all the text filds are empty or not
    if (_locationController.text.isEmpty ||
        _itemController.text.isEmpty ||
        _qtyController.text.isEmpty) {
      AlertHelper.showAlert(
        context,
        "Please fill all the fileds !",
        "Error",
        DialogType.error,
      );
      return false;
    } else {
      return true;
    }
  }

  //-------start inventory inserting
  Future<void> saveInventory(BuildContext context) async {
    try {
      if (validateField(context)) {
        //start the loader
        setLoading(true);

        await InventoryCotroller().saveInventoryData(
          context,
          _locationController.text,
          _qtyController.text,
          _itemController.text,
        );

        _qtyController.clear();
        _itemController.clear();
        _locationController.clear();

        SiteManager manager =
            // ignore: use_build_context_synchronously
            Provider.of<SiteManagerProvider>(context, listen: false)
                .siteManager;

        fetchInventory(manager.location);
        setLoading(false);
      }
    } catch (e) {
      Logger().e(e);
      setLoading(false);
    }
  }

  //-----fetch inventory function
  Future<void> fetchInventory(String location) async {
    try {
      //------start the loader
      setLoading(true);

      //----start fetching notices
      _inventory = await InventoryCotroller().getInventory(location);
      Logger().w(_inventory.length);

      notifyListeners();

      //-----stop loading
      setLoading(false);
    } catch (e) {
      setLoading(false);
      Logger().e(e);
    }
  }
}
