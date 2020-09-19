import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:klik_pijaca_app/src/models/products.dart';

class CartItemModel{

  static const ID  = "id";
  static const NAME  = "name";
  static const PRODUCT_ID = "productId";
  static const IMAGE = "image";
  static const PRICE = "price";
  static const QUANTITY = "quantity";

  String _id;
  String _name;
  String _productId;
  String _image;
  int _price;
  int _quantity;

  //getters
  String get id => _id;
  String get name => _name;
  String get productId => _productId;
  String get image => _image;
  int get price => _price;
  int get quantity => _quantity;

  CartItemModel.fromSnapShot(DocumentSnapshot snapshot){
    _id = snapshot.data()[ID];
    _name = snapshot.data()[NAME];
    _productId = snapshot.data()[PRODUCT_ID];
    _image = snapshot.data()[IMAGE];
    _price = snapshot.data()[PRICE];
    _quantity = snapshot.data()[QUANTITY];
  }
}