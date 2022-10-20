import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:logger/logger.dart';
import 'package:procurement_for_construction_industry/screens/main/home.dart';
import 'package:procurement_for_construction_industry/util/util_function.dart';

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

  // //------------fetch single user
  // Future<void> fetchUser(String id) async {
  //   try {
  //     //-start the loader
  //     setLoading(true);
  //     await AuthController().fetchUserData(id).then((value) {
  //       if (value != null) {
  //         Logger().w(value.email);

  //         _userModel = value;
  //         notifyListeners();
  //         setLoading(false);
  //       }
  //     });
  //   } catch (e) {}
  // }

  //----------Initialize and check whether the user signed in or not
  Future<void> initializeUser(BuildContext context) async {
    FirebaseAuth.instance.authStateChanges().listen((User? user) async {
      if (user == null) {
        Logger().i("User signed out !");

        UtilFunction.navigator(context, const SignUp());
      } else {
        Logger().i("User is signed in!");
        // await fetchUser(user.uid);
        // ignore: use_build_context_synchronously

        // ignore: use_build_context_synchronously
        UtilFunction.navigator(context, const MainHome());
      }
    });
  }

  // //-----------pick upload and update and user profile image
  // //------pick an image
  // //-image picker instance
  // final ImagePicker _picker = ImagePicker();

  // //-------file object
  // File _image = File("");

  // //-getter for image
  // File get image => _image;

  // //-------function to pick file from gallery
  // Future<void> selectImageAndUpload() async {
  //   try {
  //     // Pick an image
  //     final XFile? pickFile =
  //         await _picker.pickImage(source: ImageSource.gallery);

  //     //-check if the user has pick a file or not
  //     if (pickFile != null) {
  //       //-assign to the file object
  //       _image = File(pickFile.path);

  //       //--------start uploading the image after picking
  //       updateProfileImage(_image);
  //       notifyListeners();
  //     } else {
  //       Logger().e("No image selected");
  //     }
  //   } catch (e) {
  //     Logger().e(e);
  //   }
  // }

  // //--------upload and update profile image
  // Future<void> updateProfileImage(File img) async {
  //   try {
  //     //----start the loader
  //     setLoading(true);

  //     //-----start uploading the image
  //     String imgUrl =
  //         await AuthController().uploadandUpdateProfileImg(_userModel.uid, img);

  //     if (imgUrl != "") {
  //       //-----update the user model img field with return download url
  //       _userModel.img = imgUrl;
  //       notifyListeners();
  //       //-stop the loader
  //       setLoading(false);
  //     }
  //   } catch (e) {
  //     Logger().e(e);
  //     setLoading(false);
  //   }
  // }
}
