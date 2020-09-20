import 'package:flutter/material.dart';
import '../helpers/products.dart';
import '../models/products.dart';

class ProductProvider with ChangeNotifier{
  ProductsServices _productsServices = ProductsServices();
  List<ProductModel> products = [];
  List<ProductModel> productsByCategory = [];

  ProductProvider.initialize(){
    _loadProducts();
      }

    _loadProducts() async{
      products = await _productsServices.getProducts();
      notifyListeners();
    }
     
    Future loadProductsByCategory({String categoryName})async{
    productsByCategory = await _productsServices.getProductsOfCategory(category: categoryName);
    notifyListeners();
  }
}
    
