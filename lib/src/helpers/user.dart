import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:klik_pijaca_app/src/models/cart_item.dart';
import 'package:klik_pijaca_app/src/models/user.dart';

class UserServices {
  String collection = "users";
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void createUser(Map<String, dynamic> values) {
    String id = values["id"];
    _firestore.collection(collection).doc(id).set(values);
  }

  void updateUserData(Map<String, dynamic> values) {
    _firestore.collection(collection).doc(values['id']).update(values);
  }

  // List<CartItemModel> getCartItems(String userId) {
  //   return _firestore.collection(collection).doc(userId).get().then((doc) {
  //     return UserModel.fromSnapshot(doc);
  //   }).then((value) { return value.cart)};
  // }

  void addToCart({String userId, Map cartItem}) {
    _firestore.collection(collection).doc(userId).update({
      "cart": FieldValue.arrayUnion([cartItem])
    });
  }

//CHANGED
  void addToFavourite({String userId, Map cartItem}) {
    _firestore.collection(collection).doc(userId).update({
      "likedFood": FieldValue.arrayUnion([cartItem])
    });
  }

  void removeFromCart({String userId, Map cartItem}) {
    _firestore.collection(collection).doc(userId).update({
      "cart": FieldValue.arrayRemove([cartItem])
    });
  }

  void updateCart({String userId, Map cartItem, int newQuantity}) {
    getUserById(userId).then((value) => {
          for (Map item in value.cart)
            {
              if (item["productId"] == cartItem["productId"])
                {item["quantity"] = newQuantity}
            }
        });

    // update({
    //   "cart": FieldValue.arrayUnion([cartItem])
    // });
  }

  Future<UserModel> getUserById(String id) =>
      _firestore.collection(collection).doc(id).get().then((doc) {
        return UserModel.fromSnapshot(doc);
      });
}
