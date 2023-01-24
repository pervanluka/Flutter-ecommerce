import 'package:ecommerce/models/product_model.dart';
import 'package:flutter/material.dart';

class BagViewModel extends ChangeNotifier {
  late final List<Product> productsBag;

  BagViewModel() : productsBag = [];

  void addProduct(Product product) {
    productsBag.add(product);
    notifyListeners();
  }

  void removeProduct(Product product){
    productsBag.remove(product);
    notifyListeners();
  }

  void clearBag(){
    productsBag.clear();
    notifyListeners();
  }

  int get totalProduct => productsBag.length;

  double get totalPrice => productsBag.fold(0, (total, product) => total + product.price);

  bool get isBagEmpty => productsBag.isEmpty;
}