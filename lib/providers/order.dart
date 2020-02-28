import 'package:flutter/cupertino.dart';
import 'package:shop_app/providers/Cart.dart';

class OrderItem {
  final String id;
  final double price;
  final List<CartItem> products;
  final DateTime data;

  OrderItem(this.id, this.price, this.products, this.data);
}

class Order with ChangeNotifier {
  List<OrderItem> _order = [];

  List<OrderItem> get order => _order;

  addOrder(double price, List<CartItem> product) {
    _order.add(
        OrderItem(DateTime.now().toString(), price, product, DateTime.now()));
    notifyListeners();
  }
}
