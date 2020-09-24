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
    print("the total sum is:" + priceSum.toString());
    print("the total sum is:" + priceSum.toString());
    print("the total sum is:" + priceSum.toString());
    print("the total sum is:" + priceSum.toString());
    print("the quantity sum is:" + quantitySum.toString());
    print("the quantity sum is:" + quantitySum.toString());
    print("the quantity sum is:" + quantitySum.toString());
    print("the quantity sum is:" + quantitySum.toString());

    totalPrice = priceSum * quantitySum;
    print("the SUM TOTALTOTALTOTAL sum is:" + totalPrice.toString());
    print("the SUM TOTALTOTALTOTAL sum is:" + totalPrice.toString());
    print("the SUM TOTALTOTALTOTAL sum is:" + totalPrice.toString());
    print("the SUM TOTALTOTALTOTAL sum is:" + totalPrice.toString());

    notifyListeners();
  }
}
