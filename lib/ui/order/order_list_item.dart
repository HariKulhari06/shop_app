import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shop_app/providers/order.dart';

class OrderListItem extends StatefulWidget {
  final OrderItem _orderItem;

  OrderListItem(this._orderItem);

  @override
  _OrderListItemState createState() => _OrderListItemState();
}

class _OrderListItemState extends State<OrderListItem> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
      child: Column(
        children: <Widget>[
          ListTile(
            title: Text('\$${widget._orderItem.price}'),
            subtitle: Text(
              DateFormat('dd MM yyyy hh:mm').format(widget._orderItem.data),
            ),
            trailing: Icon(_isExpanded ? Icons.expand_less : Icons.expand_more),
            onTap: () {
              setState(() {
                _isExpanded = !_isExpanded;
              });
            },
          ),
          Visibility(
            visible: _isExpanded,
            child: Column(
              children: <Widget>[
                Divider(),
                Container(
                  height:
                      min(widget._orderItem.products.length * 20.0 + 60, 250),
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(
                          '${(widget._orderItem.products[index].title)}   ${(widget._orderItem.products[index].quantity)}X',
                        ),
                        trailing: Text(
                          '\$${(widget._orderItem.products[index].price)}',
                        ),
                      );
                    },
                    itemCount: widget._orderItem.products.length,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
