import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/Cart.dart';

import 'cart_list_item.dart';

class CartScreen extends StatelessWidget {
  static const String routName = '/CartScreen';

  @override
  Widget build(BuildContext context) {
    Cart _carts = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart Items'),
      ),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          children: <Widget>[
            Card(
              child: Padding(
                padding: EdgeInsets.all(15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Total',
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    Chip(
                      label: Text(
                        '\$${_carts.getTotal()}',
                        style: TextStyle(
                            color: Theme.of(context)
                                .primaryTextTheme
                                .headline1
                                .color),
                      ),
                      backgroundColor: Theme.of(context).primaryColor,
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Expanded(
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return CartListItem(_carts.items.values.toList()[index]);
                },
                itemCount: _carts.itemsCount,
              ),
            )
          ],
        ),
      ),
    );
  }
}
