import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:procurement_for_construction_industry/controllers/site_manager/site_manager_controller.dart';
import 'package:procurement_for_construction_industry/models/objects.dart';
import 'package:procurement_for_construction_industry/providers/auth/user_provider.dart';
import 'package:provider/provider.dart';

import '../../util/alert_helper.dart';

class SiteManagerProvider extends ChangeNotifier {
  //-------site manger text controller
  final _sitemanagerNameController = TextEditingController();

  //----getter for email controller
  TextEditingController get sitemanagerNameController =>
      _sitemanagerNameController;

  //-------phone text controller
  final _phoneController = TextEditingController();

  //----getter for phone controller
  TextEditingController get phoneController => _phoneController;

  //-------location text controller
  final _locationController = TextEditingController();

  //----getter for phone controller
  TextEditingController get locationController => _locationController;

  //-----site manager model
  late SiteManager _siteManager;

  //------get site manager model
  SiteManager get siteManager => _siteManager;

  //---------loader state
  bool _isLoading = false;

  //----get loading state
  bool get loading => _isLoading;

  //-----change loading state
  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  //------------fetch single sitemanager
  Future<void> fetchSiteManager(String id, BuildContext context) async {
    try {
      //-start the loader
      setLoading(true);

      await SiteManagerController().fetchSiteManagerData(id).then((value) {
        if (value != null) {
          _siteManager = value;

          notifyListeners();
          setLoading(false);
        }
      });
    } catch (e) {
      Logger().e(e);
      setLoading(false);
    }
  }

  // //-----------pick upload and update and user profile image
  // //------pick an image
  // //-image picker instance
  final ImagePicker _picker = ImagePicker();

  //-------file object
  File _image = File("");

  //-getter for image
  File get image => _image;

  // //-------function to pick file from gallery
  Future<void> selectImageAndUpload() async {
    try {
      // Pick an image
      final XFile? pickFile =
          await _picker.pickImage(source: ImageSource.gallery);

      //-check if the user has pick a file or not
      if (pickFile != null) {
        //-assign to the file object
        _image = File(pickFile.path);

        //--------start uploading the image after picking
        updateProfileImage(_image);
        notifyListeners();
      } else {
        Logger().e("No image selected");
      }
    } catch (e) {
      Logger().e(e);
    }
  }

  // //--------upload and update profile image
  Future<void> updateProfileImage(File img) async {
    try {
      //----start the loader
      setLoading(true);

      //-----start uploading the image
      String imgUrl = await SiteManagerController()
          .uploadandUpdateProfileImg(_siteManager.uid, img);

      if (imgUrl != "") {
        //-----update the user model img field with return download url
        _siteManager.img = imgUrl;
        notifyListeners();
        //-stop the loader
        setLoading(false);
      }
    } catch (e) {
      Logger().e(e);
      setLoading(false);
    }
  }

  //--validate text field function

  bool validateField(BuildContext context) {
    // first checking all the text filds are empty or not
    if (_sitemanagerNameController.text.isEmpty ||
        _phoneController.text.isEmpty ||
        _locationController.text.isEmpty) {
      AlertHelper.showAlert(
        context,
        "Please fill all the fileds !",
        "Error",
        DialogType.error,
      );
      return false;
    } else if (_phoneController.text.length > 10 ||
        _phoneController.text.length < 10) {
      AlertHelper.showAlert(
        context,
        "Phone Number should containg 10 digits !",
        "Error",
        DialogType.error,
      );
      return false;
    } else {
      return true;
    }
  }

  //-------start registering site manager
  Future<void> startSiteManagerRegistering(BuildContext context) async {
    try {
      if (validateField(context)) {
        //start the loader
        setLoading(true);
        UserModel user =
            Provider.of<UserPrivider>(context, listen: false).userModel;
        await SiteManagerController().saveSiteManagerData(
          context,
          _sitemanagerNameController.text,
          _phoneController.text,
          _locationController.text,
          user.uid,
        );

        _sitemanagerNameController.clear();
        _phoneController.clear();
        _locationController.clear();
      }
    } catch (e) {
      Logger().e(e);
    }
  }
}
