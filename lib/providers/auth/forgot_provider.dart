import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

import '../../controllers/auth_controller.dart';
import '../../util/alert_helper.dart';

class ForgotProvider extends ChangeNotifier {
  //-------email text controller
  final _emailController = TextEditingController();

  //----getter for email controller
  TextEditingController get emailController => _emailController;

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
    if (emailController.text.isEmpty) {
      AlertHelper.showAlert(
        context,
        "Please fill all the fileds !",
        "Error",
        DialogType.error,
      );
      return false;
    } else if (!emailController.text.contains("@")) {
      AlertHelper.showAlert(
        context,
        "Please Enter a valid email !",
        "Error",
        DialogType.error,
      );

      return false;
    } else {
      return true;
    }
  }

  Future<void> changePassword(BuildContext context) async {
    try {
      if (validateField(context)) {
        //start the loader
        setLoading(true);
        // Logger().i("Validation success");
        await AuthController()
            .sendPasswordResetEmail(context, emailController.text);

        //clear text field
        emailController.clear();

        //stop the loader
        setLoading(false);
      } else {
        Logger().e("authentication faild");
      }
    } catch (e) {
      AlertHelper.showAlert(context, e.toString(), 'Error', DialogType.error);
    }
  }
}
