import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:klik_pijaca_app/src/models/products.dart';

class ProductsServices{

  String collection  = "products";
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<ProductModel>> getProducts() async =>
   _firestore.collection(collection).get().then((result){
     List<ProductModel> products = [];
     for (DocumentSnapshot product in result.docs){
       products.add(ProductModel.fromSnapShot(product));
     }
     return products;
   });

   Future<List<ProductModel>> getProductsOfCategory({String category}) async =>
      _firestore.collection(collection).where("category", isEqualTo: category).get().then((result) {
        List<ProductModel> products = [];
        for(DocumentSnapshot product in result.docs){
          products.add(ProductModel.fromSnapShot(product));
        }
        return products;
      });
}