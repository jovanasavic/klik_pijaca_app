import 'package:flutter/material.dart';

class AppProvider with ChangeNotifier {
  bool isLoading = false;
  int totalPrice = 0;
  int priceSum = 0;
  int quantitySum = 0;

  void changeLoadingState() {
    isLoading = !isLoading;
    notifyListeners();
  }

  addPrice({int newPrice}) {
    priceSum += newPrice;
    notifyListeners();
  }

  addQuantity({int newQuantity}) {
    quantitySum += newQuantity;
    notifyListeners();
  }

  getTotalPrice() {
    totalPrice = priceSum * quantitySum;
    notifyListeners();
  }
}
