import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:klik_pijaca_app/src/helpers/user.dart';
import 'package:klik_pijaca_app/src/models/cart_item.dart';
import 'package:klik_pijaca_app/src/models/products.dart';
import 'package:klik_pijaca_app/src/models/user.dart';
import 'package:uuid/uuid.dart';

enum Status { Uninitialized, Authenticated, Authenticating, Unauthenticated }

class UserProvider with ChangeNotifier {
  FirebaseAuth _auth;
  User _user;
  Status _status = Status.Uninitialized;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  UserServices _userServicse = UserServices();
  UserModel _userModel;

//  getter
  UserModel get userModel => _userModel;
  Status get status => _status;
  User get user => _user;

  final formkey = GlobalKey<FormState>();

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController name = TextEditingController();

  UserProvider.initialize() : _auth = FirebaseAuth.instance {
    _auth.onAuthStateChanged.listen(_onStateChanged);
  }

  Future<bool> signIn() async {
    try {
      _status = Status.Authenticating;
      notifyListeners();
      await _auth.signInWithEmailAndPassword(
          email: email.text.trim(), password: password.text.trim());
      return true;
    } catch (e) {
      _status = Status.Unauthenticated;
      notifyListeners();
      print(e.toString());
      return false;
    }
  }

  Future<bool> signUp() async {
    try {
      _status = Status.Authenticating;
      notifyListeners();
      await _auth
          .createUserWithEmailAndPassword(
              email: email.text.trim(), password: password.text.trim())
          .then((result) {
        _firestore.collection('users').doc(result.user.uid).set({
          'name': name.text,
          'email': email.text,
          'uid': result.user.uid,
          'likedFood': []
        });
      });
      return true;
    } catch (e) {
      _status = Status.Unauthenticated;
      notifyListeners();
      print(e.toString());
      return false;
    }
  }

  Future signOut() async {
    _auth.signOut();
    _status = Status.Unauthenticated;
    notifyListeners();
    return Future.delayed(Duration.zero);
  }

  void clearController() {
    name.text = "";
    password.text = "";
    email.text = "";
  }

  Future<void> reloadUserModel() async {
    _userModel = await _userServicse.getUserById(user.uid);
    notifyListeners();
  }

  Future<bool> addToCard({ProductModel product, int quantity}) async {
    print("THE PRODUC IS: ${product.toString()}");
    print("THE qty IS: ${quantity.toString()}");

    try {
      var uuid = Uuid();
      String cartItemId = uuid.v4();
      List cart = [];
      await _userServicse
          .getUserById(_user.uid)
          .then((value) => cart = value.cart);
      //_userModel.cart;

      print("CAAAAART " + cart.toString());
      // _userServicse
      //     .getUserById(_user.uid)
      //     .then((value) => print("AAAAAAAAAAAAAAA" + value.cart.toString()));
      //bool itemExists = false;
      Map cartItem = {
        "id": cartItemId,
        "name": product.name,
        "image": product.image,
        "productId": product.id,
        "price": product.price,
        "quantity": quantity
      };
      // for (Map item in cart) {
      //   if (item["productId"] == cartItem["productId"]) {
      //     print(item["productId"].toString());
      //     itemExists = true;
      //     break;
      //   }
      // }

      // _userServicse.getCartItems(_user.uid);

      //if (!itemExists) {
      _userServicse.addToCart(userId: _user.uid, cartItem: cartItem);
      //}

      // CartItemModel item = CartItemModel.fromMap(cartItem);

      notifyListeners();
      return true;
    } catch (e) {
      print("THE ERROR ${e.toString()}");
      return false;
    }
  }

  Future<bool> removeFromCart({Map cartItem}) async {
    print("THE PRODUC IS: ${cartItem.toString()}");

    try {
      // List cart = [];
      // await _userServicse
      //     .getUserById(_user.uid)
      //     .then((value) => cart = value.cart);
      _userServicse.removeFromCart(userId: _user.uid, cartItem: cartItem);
      return true;
    } catch (e) {
      print("THE ERROR ${e.toString()}");
      return false;
    }
  }

  Future<void> _onStateChanged(User firebaseUser) async {
    if (firebaseUser == null) {
      _status = Status.Unauthenticated;
    } else {
      _user = firebaseUser;
      _status = Status.Authenticated;
      _userModel = await _userServicse.getUserById(user.uid);
    }
    notifyListeners();
  }
}
