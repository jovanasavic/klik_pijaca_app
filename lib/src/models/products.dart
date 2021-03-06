import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {
  static const ID = "id";
  static const NAME = "name";
  static const IMAGE = "image";
  static const RATING = "rating";
  static const PRICE = "price";
  static const CATEGORY = "category";
  static const FEATURED = "featured";
  static const RATES = "rates";
  static const DESCRIPTION = "description";

  String _id;
  String _name;
  String _image;
  double _rating;
  int _price;
  String _category;
  bool _featured;
  int _rates;
  String _desctiption;

  //getters
  String get id => _id;
  String get name => _name;
  String get image => _image;
  double get rating => _rating;
  int get price => _price;
  String get category => _category;
  bool get featured => _featured;
  int get rates => _rates;
  String get description => _desctiption;

  ProductModel.fromSnapShot(DocumentSnapshot snapshot) {
    _id = snapshot.data()[ID];
    _name = snapshot.data()[NAME];
    _image = snapshot.data()[IMAGE];
    _rating = snapshot.data()[RATING];
    _price = snapshot.data()[PRICE].floor();
    _category = snapshot.data()[CATEGORY];
    _featured = snapshot.data()[FEATURED];
    _rates = snapshot.data()[RATES];
    _desctiption = snapshot.data()[DESCRIPTION];
  }
}
