import 'package:flutter/material.dart';
import '../helpers/products.dart';
import '../models/products.dart';

class ProductProvider with ChangeNotifier {
  ProductsServices _productsServices = ProductsServices();
  List<ProductModel> products = [];
  List<ProductModel> productsByCategory = [];
  List<ProductModel> productsSearched = [];

  ProductProvider.initialize() {
    _loadProducts();
    search();
  }

  _loadProducts() async {
    products = await _productsServices.getProducts();
    notifyListeners();
  }

  Future loadProductsByCategory({String categoryName}) async {
    productsByCategory =
        await _productsServices.getProductsOfCategory(category: categoryName);
    notifyListeners();
  }

  Future search({String productName}) async {
    productsSearched =
        await _productsServices.serchProducts(productName: productName);
    print("THE NUMBER OF PRODUCTS DETECTED IS:" +
        productsSearched.length.toString());
    notifyListeners();
  }
}
