import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

import '../../controllers/auth_controller.dart';
import '../../util/alert_helper.dart';

class LoginProvider extends ChangeNotifier {
  //-------email text controller
  final _emailController = TextEditingController();

  //-------password text controller
  final _passwordController = TextEditingController();

  //----getter for email controller
  TextEditingController get emailController => _emailController;

  //----getter for password controller
  TextEditingController get passwordController => _passwordController;

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
    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
      AlertHelper.showAlert(
        context,
        "Please fill all the fileds !",
        "Error",
        DialogType.error,
      );
      return false;
    } else if (!_emailController.text.contains("@")) {
      AlertHelper.showAlert(
        context,
        "Please Enter a valid email !",
        "Error",
        DialogType.error,
      );

      return false;
    } else if (_passwordController.text.length < 6) {
      AlertHelper.showAlert(
        context,
        "Password must have more than 6 digits !",
        "Error",
        DialogType.error,
      );
      return false;
    } else {
      return true;
    }
  }

  //---------start signup process
  Future<void> startLogin(BuildContext context) async {
    try {
      if (validateField(context)) {
        //start the loader

        setLoading(true);

        // Logger().i("Validation success");
        await AuthController().signinUser(
          context,
          _emailController.text,
          _passwordController.text,
        );

        //clear text field
        _emailController.clear();
        _passwordController.clear();

        //stop the loader

        setLoading(false);
      }
    } catch (e) {
      setLoading(false);
      Logger().e(e);
      AlertHelper.showAlert(context, e.toString(), 'Error', DialogType.error);
    }
  }
}
