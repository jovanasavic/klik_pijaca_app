import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryModel {
  static const ID = "id";
  static const NAME = "name";
  static const IMAGE = "image";
  static const IMAGECOVER = "imageCover";

  int _id;
  String _name;
  String _image;
  String _imageCover;

  //getters
  int get id => _id;
  String get name => _name;
  String get image => _image;
  String get imageCover => _imageCover;

  CategoryModel.fromSnapShot(DocumentSnapshot snapshot) {
    _id = snapshot.data()[ID];
    _name = snapshot.data()[NAME];
    _image = snapshot.data()[IMAGE];
    _imageCover = snapshot.data()[IMAGECOVER];
  }
}
