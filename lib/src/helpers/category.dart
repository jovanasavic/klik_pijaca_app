import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:klik_pijaca_app/src/models/category.dart';

class CategoryServices{

  String collection  = "categories";
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<CategoryModel>> getCategories() async =>
   _firestore.collection(collection).get().then((result){
     List<CategoryModel> categories = [];
     for (DocumentSnapshot category in result.docs){
       categories.add(CategoryModel.fromSnapShot(category));
     }
     return categories;
   });
}