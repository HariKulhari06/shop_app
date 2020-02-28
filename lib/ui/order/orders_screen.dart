import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/order.dart';
import 'package:shop_app/ui/app_drawer.dart';
import 'package:shop_app/ui/order/order_list_item.dart';

class OrderScreen extends StatelessWidget {
  static const String routName = '/OrderScreen';

  @override
  Widget build(BuildContext context) {
    Order _order = Provider.of<Order>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Orders'),
      ),
      drawer: AppDrawer(),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return OrderListItem(_order.order[index]);
        },
        itemCount: _order.order.length,
      ),
    );
  }
}
