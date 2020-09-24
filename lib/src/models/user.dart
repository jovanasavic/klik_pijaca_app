import 'package:cloud_firestore/cloud_firestore.dart';

import 'cart_item.dart';

class UserModel {
  static const ID = "id";
  static const NAME = "name";
  static const EMAIL = "email";
  static const LIKED_FOOD = "likedFood";
  static const CART = "cart";

  String _id;
  String _name;
  String _email;
  List _likedFood;
  int _priceSum = 0;
  int _quantitySum = 0;

  //getters
  String get id => _id;
  String get name => _name;
  String get email => _email;
  List get likedFood => _likedFood;

  //public variable

  List cart;
  int totalCartPrice;

  UserModel.fromSnapshot(DocumentSnapshot snapshot) {
    _id = snapshot.data()[ID];
    _name = snapshot.data()[NAME];
    _email = snapshot.data()[EMAIL];
    _likedFood = snapshot.data()[LIKED_FOOD] ?? [];
    cart = snapshot.data()[CART] ?? [];
    totalCartPrice = getTotalPrice(cart: snapshot.data()[CART]);
  }

  int getTotalPrice({List cart}) {
    for (Map cartItem in cart) {
      _priceSum += cartItem["price"] * cartItem["quantity"];
    }
    int total = _priceSum;
    print("the total is!!!!!!!!!" + total.toString());
    return _priceSum;
  }
}
