import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:procurement_for_construction_industry/controllers/Supplier/add_item.dart';
import 'package:procurement_for_construction_industry/models/objects.dart';

import '../../util/alert_helper.dart';

class ItemProvider extends ChangeNotifier {
  //-------baby name text controller
  final _itemIDController = TextEditingController();

  //----getter for baby name controller
  TextEditingController get itemIDController => _itemIDController;

  //-------phmDivision text controller
  final _itemNameController = TextEditingController();

  //----getter for phmDivision controller
  TextEditingController get itemNameController => _itemNameController;

  //-------registration no text controller
  final _itemPriceController = TextEditingController();

  //----getter for registration no controller
  TextEditingController get itemPriceController => _itemPriceController;

  //-------registration no text controller
  final _itemQtyController = TextEditingController();

  //----getter for registration no controller
  TextEditingController get itemQTYController => _itemQtyController;

  //---------loader state
  bool _isLoading = false;

  //----get loading state
  bool get loading => _isLoading;

  //-----change loading state
  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  //------initialize the item model list
  List<ItemModel> _items = [];

  //-----getter for item list
  List<ItemModel> get items => _items;

  //-----product controller instance
  final ItemController _itemController = ItemController();

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

  // -----baby controller instance
  // final ItemController _ItemController = ItemController();

  //--validate text field function

  bool validateField(BuildContext context) {
    // first checking all the text filds are empty or not
    if (_itemIDController.text.isEmpty ||
        _itemNameController.text.isEmpty ||
        _itemPriceController.text.isEmpty ||
        _itemQtyController.text.isEmpty) {
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
  Future<void> addItem(BuildContext context) async {
    try {
      //start the loader

      setLoading(true);

      // Logger().i("Validation success");
      await ItemController().saveItem(
          context,
          _itemIDController.text,
          _itemNameController.text,
          _itemPriceController.text,
          _itemQtyController.text,
          image);

      //clear text field
      _itemIDController.clear();
      _itemNameController.clear();
      _itemPriceController.clear();
      _itemQtyController.clear();

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
  //     _clinics = await _ItemController.getclinic();
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
  //     _filterClinic = await ItemController().getBabyByName(name);
  //     return _filterClinic;
  //   } catch (e) {
  //     Logger().e(e);
  //     return [];
  //   }
  // }

  //-----fetch products function
  Future<void> fetchItems() async {
    try {
      //------start the loader
      setLoading(true);

      //----start fetching products
      _items = await _itemController.getItems();
      Logger().w(_items.length);

      notifyListeners();

      //-----stop loading
      setLoading(false);
    } catch (e) {
      Logger().e(e);
      setLoading(false);
    }
  }

  //------------item details screen
  //------------Store the selected item model
  late ItemModel _itemModel;
  //--------get selected product
  ItemModel get itemModel => _itemModel;

  //-------set item model when click from the product card
  void setItem(ItemModel model) {
    _itemModel = model;
    notifyListeners();
  }

  //-----getter for related product list
  List<ItemModel> get relatedItems {
    List<ItemModel> temp = [];
    //----------filter the product list
    //---------remove the already selected product
    for (var i = 0; i < _items.length; i++) {
      if (_items[i].id != _itemModel.id) {
        temp.add(_items[i]);
      }
    }
    return temp;
  }

  //------pick an image
  //-image picker instance
  final ImagePicker _picker = ImagePicker();

  //-------file object
  File _image = File("");

  //-getter for image
  File get image => _image;

  //-------function to pick file from gallery
  Future<void> selectImage() async {
    try {
      // Pick an image
      final XFile? pickFile =
          await _picker.pickImage(source: ImageSource.gallery);

      //-check if the user has pick a file or not
      if (pickFile != null) {
        //-assign to the file object
        _image = File(pickFile.path);
        notifyListeners();
      } else {
        Logger().e("No image selected");
      }
    } catch (e) {
      Logger().e(e);
    }
  }
}
