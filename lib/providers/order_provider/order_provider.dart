import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

import '../../controllers/order_controller.dart';
import '../../models/objects.dart';
import '../../screens/main/cart/cart.dart';
import '../../screens/main/main_screen.dart';
import '../../util/alert_helper.dart';
import '../../util/util_function.dart';
import '../auth/user_provider.dart';
import '../cart/cart_provider.dart';

class OrderProvider extends ChangeNotifier {
  final OrderController _orderController = OrderController();

  //---------loader state
  bool _isLoading = false;

  //----get loading state
  bool get loading => _isLoading;

  //-----change loading state
  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  //------start creating the order
  Future<void> createOrder(BuildContext context) async {
    try {
      //----get cart items
      List<CartItemModel> items =
          Provider.of<CartProvider>(context, listen: false).cartItemList;

      //----get cart total
      double total =
          Provider.of<CartProvider>(context, listen: false).getCartTotal;

      //----get cart items
      UserModel user =
          Provider.of<UserPrivider>(context, listen: false).userModel;

      //----first check wheather cart item list is not empty
      if (items.isNotEmpty) {
        //------start the loader
        setLoading(true);

        //-call the create order function
        await _orderController.saveOrderData(user, total, items).then((value) {
          //-stop the loader
          setLoading(false);

          //-clear the cart after created
          Provider.of<CartProvider>(context, listen: false).clearCart();

          //--show a dialog box when the order is successfully created
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) {
              return DialogBoxContainer(
                onTap: () {
                  //---start fetching orders before going to order list
                  fetchOrders(user.uid);
                  UtilFunction.navigator(context, const MainScreen());
                },
              );
            },
          );
        });
      } else {
        AlertHelper.showAlert(context, "You must add some items to cart",
            "Error", DialogType.error);
      }
    } catch (e) {
      setLoading(false);
      Logger().e(e);
    }
  }

  //-fetching orders
  //------ order list
  List<OrderModel> _orders = [];

  //-----getter for order list
  List<OrderModel> get orders => _orders;

  //-start fetching order
  Future<void> fetchOrders(String uid) async {
    try {
      //-start the loader
      setLoading(true);

      _orders = await _orderController.getOrders(uid);
      notifyListeners();

      //-stop the loader
      setLoading(false);
    } catch (e) {
      Logger().e(e);
      //-stop the loader
      setLoading(false);
    }
  }
}
