import 'package:cloud_firestore/cloud_firestore.dart';

class CartItemModel {
  static const ID = "id";
  static const NAME = "name";
  static const PRODUCT_ID = "productId";
  static const IMAGE = "image";
  static const PRICE = "price";
  static const QUANTITY = "quantity";

  String _id;
  String _name;
  int _productId;
  String _image;
  int _price;
  int _quantity;

  //getters
  String get id => _id;
  String get name => _name;
  int get productId => _productId;
  String get image => _image;
  int get price => _price;
  int get quantity => _quantity;

  CartItemModel.fromMap(Map data) {
    _id = data[ID];
    _name = data[NAME];
    _productId = data[PRODUCT_ID];
    _image = data[IMAGE];
    _price = data[PRICE];
    _quantity = data[QUANTITY];
  }

  Map toMap() => {
        ID: _id,
        IMAGE: _image,
        NAME: _name,
        PRODUCT_ID: _productId,
        QUANTITY: _quantity,
        PRICE: _price
      };
}
