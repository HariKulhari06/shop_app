import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/product_providers.dart';
import 'package:shop_app/ui/add/add_edit_screen.dart';
import 'package:shop_app/ui/app_drawer.dart';

class UserProductScreen extends StatelessWidget {
  static const String routName = '/UserProductScreen';

  @override
  Widget build(BuildContext context) {
    final Products _products = Provider.of<Products>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Products'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(AddEditScreen.routName);
            },
          )
        ],
      ),
      drawer: AppDrawer(),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: ListView.builder(
          itemBuilder: (context, index) {
            return Column(
              children: <Widget>[
                ListTile(
                  leading: CircleAvatar(
                    backgroundImage:
                        NetworkImage(_products.items[index].imageUrl),
                  ),
                  title: Text(_products.items[index].title),
                  trailing: Container(
                    width: 100,
                    child: Row(
                      children: <Widget>[
                        IconButton(
                          icon: Icon(
                            Icons.edit,
                            color: Theme.of(context).primaryColor,
                          ),
                          onPressed: () {},
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.delete,
                            color: Theme.of(context).errorColor,
                          ),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),
                ),
                Divider()
              ],
            );
          },
          itemCount: _products.items.length,
        ),
      ),
    );
  }
}
