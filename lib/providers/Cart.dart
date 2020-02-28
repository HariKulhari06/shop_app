import 'package:flutter/material.dart';
import 'package:shop_app/providers/product.dart';

class CartItem {
  final String id;
  final String title;
  final double price;
  final int quantity;

  CartItem({this.id, this.title, this.price, this.quantity});
}

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items => _items;

  int get itemsCount => _items.length;

  double getTotal() {
    double total = 0.0;
    items.forEach((key, value) {
      total += value.price * value.quantity;
    });
    return total;
  }

  addItems(Product product) {
    if (_items.containsKey(product.id)) {
      items.update(
          product.id,
          (currentItem) => CartItem(
              id: currentItem.id,
              title: currentItem.title,
              price: currentItem.price,
              quantity: currentItem.quantity + 1));
    } else {
      _items.putIfAbsent(
          product.id,
          () => CartItem(
              id: product.id,
              title: product.title,
              price: product.price,
              quantity: 1));
    }
    notifyListeners();
  }

  removeItem(String id) {
    items.remove(id);
    notifyListeners();
  }

  clear() {
    _items = {};
    notifyListeners();
  }
}
