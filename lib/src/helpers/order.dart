import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:klik_pijaca_app/src/models/cart_item.dart';
import 'package:klik_pijaca_app/src/models/order.dart';
import 'package:klik_pijaca_app/src/models/user.dart';

class OrderServices {
  String collection = "orders";
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void createOrder(
    String userId,
    String id,
    String description,
    String status,
    int totalPrice,
    List cart,
  ) {
    _firestore.collection(collection).doc(id).set({
      "userId": userId,
      "id": id,
      "cart": cart,
      "total": totalPrice,
      "createdAt": DateTime.now().millisecondsSinceEpoch,
      "description": description,
      "status": status,
    });
  }

  Future<List<OrderModel>> getUserOrders({String userId}) async => _firestore
          .collection(collection)
          .where("userId", isEqualTo: userId)
          .get()
          .then((result) {
        List<OrderModel> orders = [];
        for (DocumentSnapshot order in result.docs) {
          orders.add(OrderModel.fromSnapShot(order));
        }
        return orders;
      });
}
