import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:limitless/models/cart_model.dart';
import 'package:limitless/models/product_model.dart';
import 'package:http/http.dart' as http;

class ProductProvider with ChangeNotifier {
  bool isfound = false;
  int quantity;
  String url = 'https://fakestoreapi.com/products';
  bool productLoader = false;
  List<ProductModel> products;
  List<Cart> cartproducts = [];

  Future<List<ProductModel>> fetchProducts() async {
    productLoader = true;
    var response = await http.get(Uri.parse(url));
    var rb = response.body;
    var list = json.decode(rb) as List;
    products = list.map((i) => ProductModel.fromJson(i)).toList();
    productLoader = false;
    notifyListeners();
  }

  removeCart(index) {
    cartproducts.removeAt(index);
    getCartTotal();
    notifyListeners();
  }

  void addToCart(Cart card) {
    var x = cartproducts.indexWhere((item) => item.id == card.id);
    if (x == -1) {
      isfound = false;
      cartproducts.add(card);

      notifyListeners();
    } else {
      isfound = true;
    }
  }

  double cartTotal = 0;
  void getCartTotal() {
    if (cartproducts != null) {
      cartTotal = 0;

      for (int i = 0; i < cartproducts.length; i++) {
        cartTotal += (cartproducts[i].price);
      }
    } else {
      cartTotal = 0;
    }
    // notifyListeners();
  }
}
