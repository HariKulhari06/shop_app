import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/Cart.dart';

class CartListItem extends StatelessWidget {
  final CartItem _cartItem;

  CartListItem(this._cartItem);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 2, vertical: 5),
      child: Dismissible(
        key: ValueKey(_cartItem.id),
        background: Container(
          color: Theme.of(context).accentColor,
          child: Icon(
            Icons.delete,
            color: Colors.white,
            size: 40,
          ),
          alignment: Alignment.centerRight,
          padding: EdgeInsets.only(right: 10),
        ),
        direction: DismissDirection.endToStart,
        onDismissed: (direction) {
          Provider.of<Cart>(context, listen: false).removeItem(_cartItem.id);
        },
        child: Padding(
          padding: EdgeInsets.all(0),
          child: ListTile(
            leading: CircleAvatar(
              child: Padding(
                  padding: EdgeInsets.all(5),
                  child: FittedBox(child: Text('\$${_cartItem.price}'))),
            ),
            title: Text(_cartItem.title),
            subtitle: Text('Total \$${(_cartItem.price * _cartItem.quantity)}'),
            trailing: Text('${_cartItem.quantity}X'),
          ),
        ),
      ),
    );
  }
}
