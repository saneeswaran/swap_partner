import 'package:flutter/material.dart';
import 'package:swap_store/model/partner_product_model.dart';

class PartnerProductProvider with ChangeNotifier {
  final List<PartnerProductModel> _productList = [];

  List<PartnerProductModel> get getProduct => _productList;

  void addProductToCart(PartnerProductModel product) {
    _productList.add(product);
    notifyListeners();
  }

  void removeProductFromCart(PartnerProductModel product) {
    _productList.remove(product);
    notifyListeners();
  }
}
