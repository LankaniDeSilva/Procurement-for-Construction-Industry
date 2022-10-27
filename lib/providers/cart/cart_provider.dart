import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';

import 'package:logger/logger.dart';

import '../../models/objects.dart';
import '../../util/alert_helper.dart';

class CartProvider extends ChangeNotifier {
  //-------product counter section
  //------counter
  int _counter = 1;

  //-----get counter
  int get counter => _counter;

  //------increase counter
  void increaseCounter() {
    _counter++;
    notifyListeners();
  }

  //------decrease counter
  void decreaseCounter() {
    if (_counter != 1) {
      _counter--;
    }
    notifyListeners();
  }

  //------clear counter for one
  void clearCounter() {
    _counter = 1;
    notifyListeners();
  }

  //----add to cart
  //--------cart item list
  List<CartItemModel> _cartItemList = [];

  //--------get for cart list
  List<CartItemModel> get cartItemList => _cartItemList;

  //---------initaiate add to cart functionality
  void addToCart(ItemModel itemModel, BuildContext context) {
    //--first check wheather adding item is already int the cart list
    if (_cartItemList.any((element) => element.cartId == itemModel.id)) {
      increasecartItemCount(itemModel);

      calSubtotal(itemModel);

      //------show the snackbar
      AlertHelper.showSnackbar(
          "Increase Product Amount", AnimatedSnackBarType.success, context);
    } else {
      //-if not existing adding into the cart
      _cartItemList.add(CartItemModel(
        cartId: itemModel.id,
        qty: _counter,
        subTotal: _counter * itemModel.price,
        model: itemModel,
      ));

      //-clear counter state after adding product to the cart
      clearCounter();
      //------show the snackbar
      AlertHelper.showSnackbar(
          "Added to the cart", AnimatedSnackBarType.success, context);
    }

    Logger().w(cartItemList.length);

    notifyListeners();
  }

  //-cal subtotal
  void calSubtotal(ItemModel itemModel) {
    _cartItemList
        .singleWhere((element) => element.cartId == itemModel.id)
        .subTotal = _cartItemList
            .singleWhere((element) => element.cartId == itemModel.id)
            .qty *
        itemModel.price;

    notifyListeners();
  }

  //----increase the cart item count
  void increasecartItemCount(ItemModel itemModel) {
    //----if exists increase the product qty of the existing item
    _cartItemList
        .singleWhere((element) => element.cartId == itemModel.id)
        .qty++;

    //--- cal and update the subtotal
    calSubtotal(itemModel);
    notifyListeners();
  }

  //----decrease the cart item count
  void decreasecartItemCount(ItemModel itemModel, BuildContext context) {
    //---when decreasing qty if the qty is 1, remove item from the cart
    if (_cartItemList
            .singleWhere((element) => element.cartId == itemModel.id)
            .qty ==
        1) {
      removeCartItem(itemModel.id, context);
    } else {
      //----if exists increase the item qty of the existing item
      _cartItemList
          .singleWhere((element) => element.cartId == itemModel.id)
          .qty--;

      //--- cal and update the subtotal
      calSubtotal(itemModel);
    }

    notifyListeners();
  }

  //-remove cart
  void removeCartItem(String productId, BuildContext context) {
    _cartItemList.removeWhere((element) => element.cartId == productId);
    AlertHelper.showSnackbar(
        "Remove from the cart", AnimatedSnackBarType.error, context);
    notifyListeners();
  }

  //------------get cart items total price
  double get getCartTotal {
    double temp = 0;

    //-read the cart items list and get the sum of subtotal values as the cart total
    //and return it
    for (var i = 0; i < _cartItemList.length; i++) {
      temp += _cartItemList[i].subTotal;
    }
    return temp;
  }

  //------------get cart items total price
  int get getCartTotalItemCount {
    int temp = 0;

    //-read the cart items list and get the sum of qty values as the cart item
    //and return it
    for (var i = 0; i < _cartItemList.length; i++) {
      temp += _cartItemList[i].qty;
    }
    return temp;
  }

  //-clear cart
  void clearCart() {
    _cartItemList.clear();
  }
}
