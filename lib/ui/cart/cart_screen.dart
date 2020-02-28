import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/Cart.dart';
import 'package:shop_app/providers/order.dart';

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
      body: _carts.items.length > 0
          ? buildCartListing(context, _carts)
          : buildEmptyView(context),
    );
  }

  Widget buildCartListing(BuildContext context, Cart _carts) {
    return Padding(
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
                    style: Theme
                        .of(context)
                        .textTheme
                        .headline6,
                  ),
                  Spacer(),
                  Chip(
                    label: Text(
                      '\$${_carts.getTotal()}',
                      style: TextStyle(
                          color: Theme
                              .of(context)
                              .primaryTextTheme
                              .headline1
                              .color),
                    ),
                    backgroundColor: Theme
                        .of(context)
                        .primaryColor,
                  ),
                  Visibility(
                    visible: _carts.getTotal() > 0 ? true : false,
                    child: Container(
                      margin: EdgeInsets.only(left: 10),
                      child: OutlineButton(
                        onPressed: () {
                          Provider.of<Order>(context, listen: false).addOrder(
                              _carts.getTotal(), _carts.items.values.toList());
                          _carts.clear();
                        },
                        child: Text('Order Now'),
                      ),
                    ),
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
    );
  }

  Widget buildEmptyView(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          Icon(
            Icons.shopping_cart,
            size: 100,
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            'You have to item in your cart, press on shop to shop continuous.',
            softWrap: true,
          ),
          SizedBox(
            height: 10,
          ),
          RaisedButton(
            onPressed: () {
              Navigator.of(context).pushNamed('/');
            },
            child: Text('Shop'),
          )
        ],
      ),
    );
  }
}
