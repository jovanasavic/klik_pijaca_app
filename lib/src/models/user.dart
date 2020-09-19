import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel{
  static const ID  = "id";
  static const NAME  = "name";
  static const EMAIL  = "email";
  static const LIKED_FOOD = "likedFood";

  String _id;
  String _name;
  String _email;
  List _likedFood;

  //getters
  String get id => _id;
  String get name => _name;
  String get email => _email;
  List get likedFood => _likedFood;

  UserModel.fromSnapshot(DocumentSnapshot snapshot){
    _id = snapshot.data()[ID];
    _name = snapshot.data()[NAME];
    _email = snapshot.data()[EMAIL];
    _likedFood = snapshot.data()[LIKED_FOOD] ?? [];
  }
}