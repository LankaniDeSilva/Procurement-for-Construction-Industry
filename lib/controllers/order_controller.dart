import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import 'package:logger/logger.dart';
import 'package:procurement_for_construction_industry/util/alert_helper.dart';

import '../models/objects.dart';

class OrderController {
  //-- create the product collection
  CollectionReference orders = FirebaseFirestore.instance.collection('orders');

  //----------fetch products
  Future<List<OrderModel>> getOrders(String uid) async {
    try {
      //----------query for fetching all the order list according to the user id
      QuerySnapshot snapshot =
          await orders.where("user.uid", isEqualTo: uid).get();

      //----------product list
      List<OrderModel> orderList = [];

      //----------mapping fetch data to product model and store in product list
      for (var element in snapshot.docs) {
        Logger().w(element.data() as Map<String, dynamic>);
        //-----mapping to single order model
        OrderModel model =
            OrderModel.fromJson(element.data() as Map<String, dynamic>);
        Logger().w(model);
        //-----adding to the list
        orderList.add(model);
      }

      return orderList;
    } catch (e) {
      Logger().e(e);
      return [];
    }
  }

  //------------save order in firestore cloud
  Future<void> saveOrderData(
      UserModel user, double total, List<CartItemModel> items) async {
    //-getting an unique document ID
    String docid = orders.doc().id;

    String status;
    //-----temparory item list
    var list = [];

    //-----read the cart items list and add items to a dynamic list
    //--because we can only store dynamic type arrays in firestore
    for (var i = 0; i < items.length; i++) {
      list.add(items[i].toJson());
    }
    if (total < 100000) {
      status = "Approved";
    } else {
      status = "Pending";
    }

    await orders.doc(docid).set({
      'id': docid,
      'user': user.toJson(),
      'total': total,
      'item': list,
      'orderState': status
    });
  }

  Future<void>? deleteOrder(String id, BuildContext context) {
    try {
      return orders.doc(id).delete().then((_) {
        AlertHelper.showAlert(context, "Order deleted successfully",
            "Oder deleted", DialogType.success);
        Logger().e(id);
      }).catchError((error) => Logger().e(error));
    } catch (e) {
      Logger().e(e);
      return null;
    }
  }
}
